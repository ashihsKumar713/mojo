// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <memory>

#include "base/macros.h"
#include "base/run_loop.h"
#include "base/strings/string_util.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/application/application_test_base.h"
#include "mojo/public/cpp/bindings/error_handler.h"
#include "mojo/public/cpp/bindings/strong_binding.h"
#include "mojo/public/cpp/system/data_pipe.h"
#include "mojo/services/authenticating_url_loader_interceptor/public/interfaces/authenticating_url_loader_interceptor_meta_factory.mojom.h"
#include "mojo/services/network/public/interfaces/network_service.mojom.h"
#include "testing/gtest/include/gtest/gtest.h"

namespace mojo {

namespace {

const char kMessage[] = "Hello World\n";
const char kUser[] = "johnsmith@gmail.com";
const char kToken[] = "this_is_a_token";
const char kAuthenticationScope[] =
    "https://www.googleapis.com/auth/userinfo.email";
const char kAuthenticationHeaderName[] = "Authorization";
const char kAuthenticationHeaderValuePrefix[] = "Bearer";
const char KUrl[] = "http://www.example.com/url1";

class MockAuthenticationService : public authentication::AuthenticationService,
                                  public ErrorHandler {
 public:
  MockAuthenticationService(
      mojo::InterfaceRequest<authentication::AuthenticationService> request)
      : binding_(this, request.Pass()) {
    binding_.set_error_handler(this);
  }
  ~MockAuthenticationService() override {}

 private:
  // AuthenticationService implementation
  void SelectAccount(bool return_last_selected,
                     const SelectAccountCallback& callback) override {
    callback.Run(kUser, nullptr);
  }
  void GetOAuth2Token(const mojo::String& username,
                      mojo::Array<mojo::String> scopes,
                      const GetOAuth2TokenCallback& callback) override {
    EXPECT_EQ(kUser, username);
    EXPECT_EQ(1u, scopes.size());
    if (scopes.size())
      EXPECT_EQ(kAuthenticationScope, scopes[0]);
    callback.Run(kToken, nullptr);
  }
  void ClearOAuth2Token(const mojo::String& token) override {}

  // ErrorHandler implementation
  void OnConnectionError() override {
    // The AuthenticationService should never be closed from the other side in
    // these tests.
    DCHECK(0);
  }

  Binding<authentication::AuthenticationService> binding_;
};

class BaseInterceptor : public URLLoaderInterceptor {
 public:
  BaseInterceptor(InterfaceRequest<URLLoaderInterceptor> request)
      : binding_(this, request.Pass()) {}
  ~BaseInterceptor() override {}

 protected:
  void InterceptRequest(URLRequestPtr request,
                        const InterceptRequestCallback& callback) override {
    URLLoaderInterceptorResponsePtr interceptor_response =
        URLLoaderInterceptorResponse::New();
    interceptor_response->request = request.Pass();
    callback.Run(interceptor_response.Pass());
  }

  void InterceptResponse(URLResponsePtr response,
                         const InterceptResponseCallback& callback) override {
    URLLoaderInterceptorResponsePtr interceptor_response =
        URLLoaderInterceptorResponse::New();
    interceptor_response->response = response.Pass();
    callback.Run(interceptor_response.Pass());
  }

  void InterceptFollowRedirect(
      const InterceptFollowRedirectCallback& callback) override {
    callback.Run(URLLoaderInterceptorResponsePtr());
  }

 private:
  StrongBinding<URLLoaderInterceptor> binding_;
};

class SendHelloInterceptor : public BaseInterceptor {
 public:
  SendHelloInterceptor(InterfaceRequest<URLLoaderInterceptor> request)
      : BaseInterceptor(request.Pass()) {}
  ~SendHelloInterceptor() override {}

 private:
  void InterceptRequest(URLRequestPtr request,
                        const InterceptRequestCallback& callback) override {
    URLResponsePtr response = URLResponse::New();
    response->url = request->url;
    response->status_code = 200;
    response->status_line = "200 OK";
    response->mime_type = "text/plain";
    response->headers = request->headers.Pass();
    uint32_t num_bytes = arraysize(kMessage);
    MojoCreateDataPipeOptions options;
    options.struct_size = sizeof(MojoCreateDataPipeOptions);
    options.flags = MOJO_CREATE_DATA_PIPE_OPTIONS_FLAG_NONE;
    options.element_num_bytes = 1;
    options.capacity_num_bytes = num_bytes;
    DataPipe data_pipe(options);
    response->body = data_pipe.consumer_handle.Pass();
    MojoResult result =
        WriteDataRaw(data_pipe.producer_handle.get(), kMessage, &num_bytes,
                     MOJO_WRITE_DATA_FLAG_ALL_OR_NONE);
    EXPECT_EQ(MOJO_RESULT_OK, result);

    URLLoaderInterceptorResponsePtr interceptor_response =
        URLLoaderInterceptorResponse::New();
    interceptor_response->response = response.Pass();
    callback.Run(interceptor_response.Pass());
  }
};

class PassThroughIfAuthenticatedInterceptor : public BaseInterceptor {
 public:
  PassThroughIfAuthenticatedInterceptor(
      InterfaceRequest<URLLoaderInterceptor> request)
      : BaseInterceptor(request.Pass()), initial_request_(true) {}
  ~PassThroughIfAuthenticatedInterceptor() override {}

 private:
  void InterceptRequest(URLRequestPtr request,
                        const InterceptRequestCallback& callback) override {
    URLLoaderInterceptorResponsePtr interceptor_response =
        URLLoaderInterceptorResponse::New();

    if (initial_request_) {
      // Send a response indicating that authentication is required.
      URLResponsePtr response = URLResponse::New();
      response->url = request->url;
      response->status_code = 401;
      response->status_line = "401 Authorization Required";
      initial_request_ = false;
      interceptor_response->response = response.Pass();
    } else {
      // Check that authentication is present, and if so, let the request
      // through.
      EXPECT_TRUE(request->headers.size() == 1u);
      HttpHeaderPtr header = request->headers[0].Pass();
      EXPECT_EQ(kAuthenticationHeaderName, header->name);

      std::vector<std::string> auth_value_components;
      Tokenize(header->value, " ", &auth_value_components);
      bool found_authentication = false;
      EXPECT_EQ(2u, auth_value_components.size());
      if (auth_value_components.size() == 2) {
        EXPECT_EQ(kAuthenticationHeaderValuePrefix, auth_value_components[0]);
        EXPECT_EQ(kToken, auth_value_components[1]);
        found_authentication = true;
      }

      if (found_authentication) {
        request->headers.reset();
        interceptor_response->request = request.Pass();
      } else {
        URLResponsePtr response = URLResponse::New();
        response->status_code = 404;
        response->status_line = "404 Not Found";
        interceptor_response->response = response.Pass();
      }
    }

    callback.Run(interceptor_response.Pass());
  }

  bool initial_request_;
};

template <class I>
class URLLoaderInterceptorFactoryImpl : public URLLoaderInterceptorFactory {
 public:
  URLLoaderInterceptorFactoryImpl(
      InterfaceRequest<URLLoaderInterceptorFactory> request)
      : binding_(this, request.Pass()) {}
  ~URLLoaderInterceptorFactoryImpl() override {}

 private:
  void Create(
      mojo::InterfaceRequest<URLLoaderInterceptor> interceptor) override {
    new I(interceptor.Pass());
  }

  StrongBinding<URLLoaderInterceptorFactory> binding_;
};

class AuthenticatingURLLoaderInterceptorAppTest
    : public test::ApplicationTestBase {
 public:
  AuthenticatingURLLoaderInterceptorAppTest() {}
  ~AuthenticatingURLLoaderInterceptorAppTest() override {}

  void SetUp() override {
    ApplicationTestBase::SetUp();

    application_impl()->ConnectToService("mojo:network_service",
                                         &network_service_);
    application_impl()->ConnectToService(
        "mojo:authenticating_url_loader_interceptor",
        &interceptor_meta_factory_);
  }

  void TearDown() override {
    // Close the AuthenticationService explicitly here so that teardown code
    // doesn't cause
    // it to receive an OnConnectionError() call.
    CloseAuthenticationService();
    ApplicationTestBase::TearDown();
  }

  URLResponsePtr GetResponse(const std::string& url) {
    URLRequestPtr request = URLRequest::New();
    request->url = url;
    URLLoaderPtr loader;
    network_service_->CreateURLLoader(GetProxy(&loader));
    URLResponsePtr response;
    {
      base::RunLoop loop;
      loader->Start(request.Pass(), [&response, &loop](URLResponsePtr r) {
        response = r.Pass();
        loop.Quit();

      });
      loop.Run();
    }
    return response.Pass();
  }

  template <class I>
  void AddInterceptor() {
    URLLoaderInterceptorFactoryPtr factory;
    new URLLoaderInterceptorFactoryImpl<I>(GetProxy(&factory));
    network_service_->RegisterURLLoaderInterceptor(factory.Pass());
  }

  void AddAuthenticatingURLLoaderInterceptor() {
    DCHECK(!authentication_service_impl_);
    authentication::AuthenticationServicePtr authentication_service;
    authentication_service_impl_.reset(
        new MockAuthenticationService(GetProxy(&authentication_service)));
    mojo::URLLoaderInterceptorFactoryPtr interceptor_factory;
    interceptor_meta_factory_->CreateURLLoaderInterceptorFactory(
        GetProxy(&interceptor_factory), authentication_service.Pass());
    network_service_->RegisterURLLoaderInterceptor(interceptor_factory.Pass());
  }

  void CloseAuthenticationService() { authentication_service_impl_.reset(); }

 protected:
  void ParseHelloResponse(URLResponsePtr response) {
    EXPECT_TRUE(response);
    EXPECT_EQ(200u, response->status_code);
    EXPECT_EQ(KUrl, response->url);
    EXPECT_EQ(0u, response->headers.size());
    char received_message[arraysize(kMessage)];
    uint32_t num_bytes = arraysize(kMessage);
    EXPECT_EQ(MOJO_RESULT_OK,
              ReadDataRaw(response->body.get(), received_message, &num_bytes,
                          MOJO_READ_DATA_FLAG_NONE));
    EXPECT_EQ(arraysize(kMessage), num_bytes);
    EXPECT_EQ(0, memcmp(kMessage, received_message, num_bytes));
  }

  NetworkServicePtr network_service_;
  AuthenticatingURLLoaderInterceptorMetaFactoryPtr interceptor_meta_factory_;

  DISALLOW_COPY_AND_ASSIGN(AuthenticatingURLLoaderInterceptorAppTest);

 private:
  std::unique_ptr<MockAuthenticationService> authentication_service_impl_;
};

}  // namespace

// Test that the authenticating interceptor passes through a response that
// does not indicate that authentication is required if authentication is not
// available.
TEST_F(AuthenticatingURLLoaderInterceptorAppTest, AuthenticationNotRequired) {
  AddInterceptor<SendHelloInterceptor>();
  AddAuthenticatingURLLoaderInterceptor();
  CloseAuthenticationService();

  ParseHelloResponse(GetResponse(KUrl));
}

// Test that the authenticating interceptor passes through a response that
// indicates that authentication is required if authentication is not
// available.
TEST_F(AuthenticatingURLLoaderInterceptorAppTest, AuthenticationNotAvailable) {
  AddInterceptor<SendHelloInterceptor>();
  AddInterceptor<PassThroughIfAuthenticatedInterceptor>();
  AddAuthenticatingURLLoaderInterceptor();
  CloseAuthenticationService();

  URLResponsePtr response = GetResponse(KUrl);
  EXPECT_TRUE(response);
  EXPECT_EQ(401u, response->status_code);
  EXPECT_EQ(KUrl, response->url);
  EXPECT_EQ(0u, response->headers.size());
}

// Test that the authenticating interceptor adds an authentication header to  a
// response that indicates that authentication is required if authentication is
// available.
TEST_F(AuthenticatingURLLoaderInterceptorAppTest, AuthenticationAvailable) {
  AddInterceptor<SendHelloInterceptor>();
  AddInterceptor<PassThroughIfAuthenticatedInterceptor>();
  AddAuthenticatingURLLoaderInterceptor();

  ParseHelloResponse(GetResponse(KUrl));
}

}  // namespace mojo

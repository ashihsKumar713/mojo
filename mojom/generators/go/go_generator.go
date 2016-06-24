// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package main

import (
	"flag"
	"log"
	"os"
	"path/filepath"

	"mojom/generators/common"
	"mojom/generators/go/templates"
	"mojom/generators/go/translator"
)

func main() {
	log.SetFlags(0)
	flagSet := flag.NewFlagSet("Generator Go Flag Set", flag.ExitOnError)
	var noGoSrc bool
	flagSet.BoolVar(&noGoSrc, "no-go-src", false, "Do not prepend the output path with go/src.")

	config := common.GetCliConfigWithFlagSet(os.Args, flagSet)
	t := translator.NewTranslator(config.FileGraph())
	goConfig := goConfig{config, t, noGoSrc}
	t.Config = goConfig
	common.GenerateOutput(WriteGoFile, goConfig)
}

type goConfig struct {
	common.GeneratorConfig
	translator translator.Translator
	noGoSrc    bool
}

func (c goConfig) OutputDir() string {
	if c.noGoSrc {
		return c.GeneratorConfig.OutputDir()
	} else {
		return filepath.Join(c.GeneratorConfig.OutputDir(), "go", "src")
	}
}

func WriteGoFile(fileName string, config common.GeneratorConfig) {
	writer := common.OutputWriterByFilePath(fileName, config, ".mojom.go")
	goConfig := config.(goConfig)
	fileTmpl := goConfig.translator.TranslateMojomFile(fileName)
	writer.WriteString(templates.ExecuteTemplates(fileTmpl))
}

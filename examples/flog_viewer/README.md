Formatted Log Viewer
====

flog_viewer is a mojo command-line app for viewing flog logs. It's currently
under development and will change considerably over time.

# Flog Logging Concepts

The flog service logs both unformatted (file/line/text) and formatted log
messages. A client that wants to log messages in C++ can use either the
MOJO_DLOG macro to log unformatted messages or the FLOG macro to log formatted
messages. In either case, log messages end up in persistent storage managed by
the flog service. See the [main flog c++ include file](https://github.com/domokit/mojo/blob/master/mojo/services/flog/cpp/flog.h)
for more details about how logging clients produce messages.

The logging service creates a new log file for each instance of the FlogLogger
interface that's created. If the logging client is using `flog.h` in the usual
way, that means there's a new log file for every process in which
`FLOG_INITIALIZE` is called.

Log files contain messages in a binary format and are not intended to be read
by humans. The purpose of flog_viewer is to display log files in one of a few
human-readable formats.

A log file is identified by a unique numeric id assigned by the logging service
and a label, which is specified by the logging client in `FLOG_INITIALIZE`.
Log file IDs are assigned in sequence starting with 1, so the newest log file
has the highest ID. The label generally identifies the type of service hosted
in the process in question.

Messages in a log file appear in chronological order and are timestamped. Each
message is associated with a 'channel', which is identified with an integer.
Channel 0 is reserved for unformatted messages. Other channel ids are assigned
to new channels as they are created.

A channel has a lifetime within a file. When a channel is created, it is
assigned a fresh ID (one that has never been used in that file), and a channel
creation message is logged. When a channel is deleted, a channel deletion
message is logged, and the channel ID is retired, never to be used again in
that log file. Between the creation message and the deletion message, the log
file can contain any number of *channel messages* associated with that channel.
A log file can end with multiple channels still active. The channel deletion
messages only appear for those channels that were explicitly deleted by the
logging client.

Channels (other than channel 0) have an associated type, a string which matches
the `ServiceName` annotation of some mojo interface. That type is declared in
the channel creation message. Each of the channel messages is a serialized
message corresponding to one of the methods in the mojo interface.

From the logging client's perspective, a channel is a special mojo proxy
created using the `FLOG_CHANNEL` macro. Mojo interfaces used for this purpose
can't have any methods with responses and must be annotated with `ServiceName`.
To log channel messages in the log file, the logging client just calls methods
on the logging proxy.

# Using flog_viewer

flog_viewer is invoked like any other mojo application:

```
$ mojo/devtools/common/mojo_run "mojo:flog_viewer <options>"
```

With no options, the viewer lists the existing files:

```
$ mojo/devtools/common/mojo_run "mojo:flog_viewer"

     id  label
-------- ---------------------------------------------
       1 audio_service
       2 media_factory
       3 media_factory
       4 audio_service
```

To view a particular log file, pass the file's id as an argument to the app:

```
$ mojo/devtools/common/mojo_run "mojo:flog_viewer 3"
```

You can also view the last file in the list or the last file with a particular
label:

```
$ mojo/devtools/common/mojo_run "mojo:flog_viewer --last"
$ mojo/devtools/common/mojo_run "mojo:flog_viewer --last=media_factory"
```

The two command lines above display logs 4 and 3 respectively.

To see only specific channels, use the 'channels' option:

```
$ mojo/devtools/common/mojo_run "mojo:flog_viewer --last --channels=1,3,7"
```

Logs are viewed in a particular format. Currently, there are three defined
formats:

1. *terse* (the default): Log messages in order, excluding highly repetitive
   messages.
2. *full*: Every log message in order.
3. *digest*: A summary per channel.

For example, to view the last log file in digest format:

```
$ mojo/devtools/common/mojo_run "mojo:flog_viewer --last --format=digest"
```

In order to view nicely-formatted channel messages, a *channel handler* needs
to be implemented for the type of channel in question. If no such handler is
implemented, the default channel handler is used. It shows hex dumps of
channel messages and produces no output in digest format.

Specific log files can be deleted as follows:

```
$ mojo/devtools/common/mojo_run "mojo:flog_viewer --delete-logs=3,5"
```

All the logs can be deleted like this:
```
$ mojo/devtools/common/mojo_run "mojo:flog_viewer --delete-all-logs"
```

An attempt to delete a file that's currently being read or written will fail
silently. The log service doesn't reuse log ids as long as it's running. If it
terminates and recovers, however, it starts numbering new logs at the maximum
existing log id plus one.

# Implementing Channel Handlers

A *channel handler* is an object instantiated by the log viewer to handle
viewing of a particular channel. Channel handlers are created based on the
type name of the channel (which is also the `ServiceName` of a mojo interface
definition) and the name of the chosen format. Channel handlers derive from the
ChannelHandler class and are instantiated by ChannelHandler::CreateHandler, a
static method.

To create a new channel handler, add code for the implementation class in
flog_viewer/handlers, and add code to create instances of the class in
ChannelHandler::CreateHandler.

ChannelHandler defines two virtual methods (other than the destructor) that can
be overridden by subclasses. `HandleMessage`, which is pure virtual, handles a
message, and `GetAccumulator` gets the handler's *accumulator*, if it has one.

An accumulator is essentially the running state of a handler. Channel handlers
that summarize or otherwise analyze channel messages record their findings in
an accumulator, which can be sampled by the log viewing framework. Currently,
accumulators are only used for the 'digest' format and are only sampled when
the channel terminates. In the future, there may be multiple formats that use
accumulators, and the viewer may allow the user to see message-by-message
updates to accumulators.

Accumulators have few common characteristics at the moment. They all implement
a `Print` method. They also support the notion of 'problems' (errors that the
channel handler has discovered in the message stream). For example, a
message that appears out of order may be reported as a problem.

# Intended Improvements

1. Merged view of multiple log files.
2. Unifying identity across message pipes (i.e. determining what channel is
   associated with the service represented by a mojo proxy).
3. Concurrent read/write of log files.
4. Interactive log browsing including accumulator display at any point in time.
5. Use code generation or generated type reflection for printing channel
   messages.
6. Transition to Dart implementation with graphical UI.

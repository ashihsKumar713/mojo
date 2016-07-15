Example Audio Track Clients
====

play_tone and play_wav are command line client applications that play audio
directly through an audio track obtained from the audio server. The media
player isn't used.

play_tone plays a sine wave forever.

play_wav plays a piano sample from http://www.kozco.com/tech/piano2.wav and
terminates when playback is complete.

Command lines are as follows:

```
$ mojo/devtools/common/mojo_run https://core.mojoapps.io/play_tone.mojo
$ mojo/devtools/common/mojo_run https://core.mojoapps.io/play_wav.mojo
```

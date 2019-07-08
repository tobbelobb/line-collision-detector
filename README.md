## Line Collision Detector

Hangprinters have lines that point downwards to fixed anchor points during print.
That means than Hangprinter users must plan carefully, so the lines never touch the already printed material during a print.
This program should let Hangprinter users verify that lines will or will not collide with the
print, before pressing print.

## Toolchain

This project compiles in Docker

Everything inside `.` will be available from Docker at compile time.
This means you can edit the source files from your own OS, using any IDE or text editor you'd like.

Generally, everything one might need from the OS in order to compile and work on this project
should be available in this directory.

One level deeper, that is inside `./line-collision-detector`, we have a build2 project defined.
The build2 build tool, and its norms, dictates the structure and contents of that folder.
See [Canonical Project Structure](https://build2.org/build2-toolchain/doc/build2-toolchain-intro.xhtml#structure-canonical)
in the build2 introduction.

Yet another level deeper, inside `./line-collision-detector/line-collision-detector`, is the actual source.

## Compiling
Starting from a Debian/Ubuntu OS:
```
$ sudo apt intall docker docker.io
$ sudo usermod -a -G docker $USER
$ sudo reboot
...
$ ./build-docker.sh
$ ./docker-shell.sh
#
```
... and from there on you have access to one bash shell within the compile-container.
This is the suggested way to compile in that terminal
```
# cd line-collision-detector
# b
```
Execute with:
```
# ./line-collision-detector/line-collision-detector/line-collision-detector
```

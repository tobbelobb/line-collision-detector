## Line Collision Detector

Hangprinters have lines that point downwards to fixed anchor points during print.
That means than Hangprinter users must plan carefully, so the lines never touch the already printed material during a print.
This program should let Hangprinter users verify that lines will or will not collide with the
print, before pressing print.

## Toolchain

This project compiles in Docker

Everything inside `.` will be available from Docker at compile time.
This means you can edit the source files from your own OS, using any IDE or text editor you'd like.


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
# bdep init --config-create ../bdep-configs/gcc cc config.cxx=g++
# b
```

## Line Collision Detector

Hangprinters have lines that point downwards to fixed anchor points during print.
That means we have to be careful, so the lines never touch the already printed material.
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
$ ./dbuild.sh
$ ./dcompile.sh
#
```
... and from there on you are in the compile-container.
This is the suggested way to compile
```
# cd line-collision-detector
# bdep init --config-create ../bdep-configs/gcc cc config.cxx=g++
# b
```

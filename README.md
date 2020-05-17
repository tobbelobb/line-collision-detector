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

One level deeper, that is inside `./linc`, we have a build2 project defined.
The build2 build tool, and its norms, dictates the structure and contents of that folder.
See [Canonical Project Structure](https://build2.org/build2-toolchain/doc/build2-toolchain-intro.xhtml#structure-canonical)
in the build2 introduction.

Yet another level deeper, inside `./linc/linc`, is the actual source.

## Compiling
Starting from a Debian/Ubuntu OS:
```
$ sudo apt install docker docker.io
$ sudo usermod -a -G docker $USER
$ sudo reboot
... <lots of time>
$ ./build-docker.sh
... <lots of time>
$ ./docker-shell.sh
#
```
... and from there on you have access to one bash shell within the compile-container.
This is the suggested way to compile in that terminal
```
# cd /line-collision-detector/linc
# b
```
Execute with:
```
# /line-collision-detector/linc-gcc/linc/linc
```
Or simply
```
# run
```
## Compilation database
If you need the compilation database (`compile_commands.json`), this can
be generated within the Docker container with the following commands:
```
# cd /line-collision-detector/linc
# ./make_compilation_database.sh
```
It actually creates two versions:
```
/line-collision-detector/compile_commands.json # with absolute paths
```
... as required by the `./tidy.sh` script. And also
```
/line-collision-detector/linc/compile_commands.json # with relative paths
```
... as required for running tools on your native machine.
For example, you may start for example an rtags server (a c++ code indexing tool) on your native machine like this:
```
$ cd linc
$ rdm &
$ rc -J .
```
## Indent your code
In a docker shell do
```
# cd /line-collision-detector
# ./indent.sh
```
This will indent both c++ code and Bash code in this repo.

## Tidy your code
In a docker shell do
```
# cd /line-collision-detector
# ./tidy.sh
```
This will check the c++ code and complain about places where we break our tidy-rules.


## Compile with clang++-10

## Update gcc
If a new version of gcc/g++ comes out, and you want to use it, do
```
$ docker pull gcc
$ ./build-docker.sh
... <wait a long time>

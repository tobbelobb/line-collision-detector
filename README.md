## Line Collision Detector

Hangprinters have lines that point downwards to fixed anchor points during print.
That means than Hangprinter users must plan carefully, so the lines never touch the already printed material during a print.
This program should let Hangprinter users verify that lines will or will not collide with the
print, before pressing print.

Here's a visualisation of where my HP's lines would touch, if it tried to print a 980 mm tall Benchy:

![](media/demo_small.gif)

The purpose of this project is not to make fancy visualizations, but to give Hangprinter users
a quick answer to the question

![](media/does_it_fit.png)

The above gif was made with Openscad and `demo-and-algorithm-outline.scad` found in this repo.
Unfortunately, Openscad is not a practical solution, since it requires a very clean and very small mesh
to be able to perform the required analysis.

Creating the above gif took me (tobben) ~1h, including cleaning and reducing the mesh.
When modelling, we want an answer within seconds.
That is why I've made a from-scratch analysis tool, written in C++20.
It is found in the linc subrepo.

## Status
Should work.

Code is written and tested a few times.
There are no known bugs, but there might be bugs.

### How to Build Trust in the Computed Result

If you get collision detected:
Use the -o flag and generate a debug model.
Inspect this model in any other program that can visualize stl files.
Confirm visually that a detected collision is indeed a collision.

If you get no collision detected:
Scale up your model gradually until you get collision detected.
Inspect the collision with -o.
Convince yourself that any smaller version would avoid collision.

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
$ docker pull gcc
$ ./build-docker.sh
... <lots of time>
$ ./docker-shell.sh
#
```
... and from there on you have access to one bash shell within the compile-container.
This is the suggested way to compile in that terminal
```
# cd /line-collision-detector/linc
# faster
# b
```
If it complains that buildfile doesn't exist, then the linc submodule hasn't been updated.
On the host system, do this:
```
$ git submodule update --init --recursive
```
... and try again to build like described above.


After a successful build, execute with:
```
# /line-collision-detector/linc-gcc/linc/linc
```
Or simply
```
# run
```

It will tell you how it wants to be used.
Be aware that it will create a file called `linc.log`.
It may also create a debug model, if you asked for it.
This model is meant to be inspected visually in another program.

## Compilation database
If you need the compilation database (`compile_commands.json`), this can
be generated within the Docker container with the following command:
```
# make-compilation-database.sh
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
In a docker shell, from anywhere, do
```
# indent.sh
```
This will indent both c++ code and Bash code in this repo.

## Tidy your code
In a docker shell, from anywhere, do
```
# tidy.sh
```
If you only want to tidy one file, give the filename as an argument

This will check the c++ code and complain about places where we break our tidy-rules.
It will also apply fixes automatically where it can.

# Build and run all tests
In the Docker shell, do
```
# cd /line-collision-detector/linc/
# b test
```
There's an abbreviation for that, so you can just do
```
# t
```

# Compile faster
Some of our header-only dependencies can be built into static library files instead.
This is useful during development since it gives faster compile times.
To enable this, do
```
# faster.sh
```


## Update gcc
If a new version of gcc/g++ comes out, and you want to use it, do
```
$ docker pull gcc
$ ./build-docker.sh
... <wait a long time>

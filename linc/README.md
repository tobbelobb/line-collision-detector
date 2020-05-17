This directory is used as the main base directory for build2 commands.


## Build2 cheat sheet
### Build
```
# b
```

### Build and run the tests
```
# b test
```

### Clean
```
# b clean
```

### Check which configs exist
```
# bdep config list
```

### Create a config
```
# bdep init --config-create ../linc-gcc8 cc config.cxx=g++-8

```

### Build with all configs
```
# bdep update -a
```

### Build and run tests with all configs
```
# bdep test -a
```

## More on build2 tests
The test setup deserves some more explanation.
There are two kinds of tests:

#### Functional tests (testscripts)
These are the ones called for example `somename.testscript`.
These tests are the tests written in build2's own Testscript language.
They are basically bash-scripts linked to executable build targets.
They run the associated executable (in our example: `somename`) and matches expected output based on input.
Associations between executables and testscripts are created in the buildfile as part of the test build process.

#### Unit tests
These are written in c++.
They are defined in files `somename.test.cxx`, who are compiled into executables `somename.test`.
The test executables end up in the same directory where the main `linc` binary itself ends up.
They are also symlinked from the source directory like the `linc` binary.
To run a unit tests means to execute its executable with no arguments.

Note that we can associate a test executable with a testscript.
The file names will be `somename.test.testscript`.
In the testscript we can give the test executable arguments and check the output.
So we can create functional tests based on unit tests.

#### Automatic magic
Also note that the buildfile need not be changed for new `.test.cxx`, `.test.hxx`, or `.testscript`
files to be compiled and executed together with the other tests by the `b test` command.

New `.hxx` and `.cxx` files are also automatically compiled into both main executable and unit test executables.

Both build and unit testing is incremental, so only meaningfully changed source code is compiled and tested
with `b` and `b test`.

Build2 is nice, but not widely used, so many will need to skim through it's [docs](https://build2.org/build2/doc/build2-build-system-manual.xhtml)
to fully control how this project is built and managed.

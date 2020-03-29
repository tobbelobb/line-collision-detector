This directory is used as the main base directory for build2 commands.


## Build2 cheat sheet
### Clean
```
# b clean
```

### Create a config
```
# bdep init --config-create ../bdep-configs/gcc cc config.cxx=g++

```

### Build and run tests
```
# b test
```

The test setup deserves some more explanation.
There are two kinds of tests:

#### Functional tests
These tests are the tests written in build2's own Testscript language.
They are basically bash-scripts linked to executable build targets.
They run the linc executable and matches expected output based on input.

#### Test binaries
These are tests of each individual class, written in c++.
They are compiled into binaries with filenames ending with `.test`.
The test binaries end up in the same `../linc-out` directory where the main `linc` binary itself ends up.
They are also symlinked from the source directory like the `linc` binary.


Build2 is nice, but not widely used, so many will need to skim through it's [docs](https://build2.org/build2/doc/build2-build-system-manual.xhtml)
to fully control how this project is built and managed.

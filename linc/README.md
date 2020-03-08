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

### Build and run functional tests
These tests are the tests written in build2's own Testscript language.
They are basically bash-scripts linked to executable build targets.
They run the executable and matches expected output based on input.
```
# b test
```

### Build only the triangle-mesh-test target:
```
# b linc/exe{triangle-mesh-test}
```

Build2 is nice, but not widely used, so many will need to skim through it's [docs](https://build2.org/build2/doc/build2-build-system-manual.xhtml)
to fully control how this project is built and managed.

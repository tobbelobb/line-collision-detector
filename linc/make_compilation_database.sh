b -vn clean update |& compiledb
# b will use absolute paths somtimes
# To make the resulting file compatible with the world outside the contained,
# we're just replacing text to create relative paths
sed --in-place "s/-I\/line-collision-detector/-I./" compile_commands.json
sed --in-place "s/\"\/line-collision-detector\/linc/\"./" compile_commands.json
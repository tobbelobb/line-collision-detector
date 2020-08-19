
# Be sure that Benchys at all the specified scales exist before you run this script...
for scale in 2 3 4 5 6 7 8 9 10 11 12 13 14 15 15.675 15.7 16 16.4 17 18 19 20; do
echo "scale ${scale}: " | tr -d '\n';
for i in 1 2 3 4 5 6; do { time run linc/linc/test-models/broken/3DBenchy_scale${scale}.binary.stl linc/linc/params-example >/dev/null; } 2>&1 | grep real | sed -E 's/real\s.+\m([0-9]+\.[0-9]+)s$/\1, /' | tr -d '\n'; done; echo ''
done;

c = "gcc -shared -o nunchuck.so lib/nunchuck/ext/src/nunchuck.c -fPIC"
puts c
system c

c = "mv nunchuck.so lib/nunchuck/ext/lib/nunchuck.so"
puts c
system c

# Idris FreeRTOS port
Run multi-threaded Idris applications on FreeRTOS.

## Configure
```
mkdir build # From top-level of FreeRTOS-community-ports repo
cd build
cmake -G Ninja -DCMAKE_TOOLCHAIN_FILE=../cmake/gcc-arm-toolchain.cmake ..
```

## Build and run on QEMU
```
ninja -v qemu.demo-ARM926ejs-Idris```

## Debug in GDB and QEMU
In terminal 1:
```
ninja gdbserver.demo-ARM926ejs-Idris
```
In terminal 2:
```
ninja gdb.demo-ARM926ejs-Idris
```

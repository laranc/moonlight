# Moonlight
A highly experimental C build system written in Lua.

## About
Moonlight is a C build system for Linux, its only dependencies are LuaJIT and a
C compiler.

An example `build.lua`:
```lua
require("moonlight")

StartBuild()
local exe = Executable:Create(ExecutableOptions("project"))
exe:AddFile("./src/main.c")
exe:Install()
RunCommand(exe.outputPath)
EndBuild()
```

To use Moonlight all you need is to copy `moonlight.lua` into your project
root, write a `build.lua` file and run it with `luajit build.lua`. [Samurai](https://github.com/michaelforney/samurai)
is baked into `moonlight.lua` using LuaJIT's FFI.

## Acknowledgements
This project takes heavy inspiration from [mate.h](https://github.com/TomasBorques/mate.h),
and the Zig build system. Moonlight would not be possible without [Samurai](https://github.com/michaelforney/samurai),
the licence for which can be found in [here](https://github.com/michaelforney/samurai/blob/master/LICENSE)

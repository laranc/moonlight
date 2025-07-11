# Moonlight
A highly experimental C build system written in Lua.

## About
Moonlight is a C build system for Linux, its only dependencies are LuaJIT and a
C compiler.

### build.lua
An example `build.lua`:

```lua
require("moonlight")

StartBuild()

local exe = Executable:Create(ExecutableOptions("someproject"))
exe:AddFiles("./src/main.c")
exe:Install()

EndBuild()

RunCommand(exe.outputPath)
```

To use Moonlight all you need is to copy `moonlight.lua` into your project
root, write a `build.lua` file and run it with `luajit build.lua`. [Samurai](https://github.com/michaelforney/samurai)
is baked into `moonlight.lua` and is decoded and stored in the build directory.

### package.lua
An example `package.lua`

```lua
return {
    name = "somepackage",
    includePaths = {},
    build = function(dir, rules)
        local lib = StaticLib:Create(StaticLibOptions("somepackage"))
        lib:AddFiles(dir .. "/src/*.c")
        lib:Install()
        return lib
    end,
}
```

Moonlight also allows you to write packages for easy dependency management. 
The package build function will be called at the start of `Executable:Install`
/ `StaticLib:Install`. Moonlight builds recursively and prevents dependency
cycles, allowing packages to import other packages.

## Acknowledgements
This project takes heavy inspiration from [mate.h](https://github.com/TomasBorques/mate.h),
and the Zig build system. Moonlight would not be possible without [Samurai](https://github.com/michaelforney/samurai),
the licence for which can be found [here](https://github.com/michaelforney/samurai/blob/master/LICENSE)

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
    name = "somepackage", -- package name
    includes = nil, -- include directory
    build = function(dir, rules) -- build function
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

Add the following to your `build.lua` to import a package:

```lua
local dep = Package:Import("./lib/dep")
exe:AddDependency(dep)
```

### port.lua
An example `port.lua`
```lua
return {
    includes = nil, -- include directory
    staticLibs = "build/*.a", -- output files
    sysLibs = "m pthread", -- system libraries to linked against the executable
    cmd = "mkdir build && cd build && cmake .. && make", -- build command
}
```

Moonlight can allow you to build libraries with custom build commands, called
ports. This allows you to include dependencies compiled with CMake or any other
build system into your Moonlight project. The build command is executed on
import, rather than when the `Install` function is called. All paths are
relative to the directory containing `port.lua`.

Add the following to your `build.lua` to bind the port to your executable:

```lua
local port = Port:Get("./lib/somelib")
exe:BindPort(port)
```

## Acknowledgements
This project takes heavy inspiration from [mate.h](https://github.com/TomasBorques/mate.h),
and the Zig build system. Moonlight would not be possible without [Samurai](https://github.com/michaelforney/samurai),
the licence for which can be found [here](https://github.com/michaelforney/samurai/blob/master/LICENSE)

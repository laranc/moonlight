return {
	includes = "src",
	staticLibs = "build/raylib/libraylib.a",
	sysLibs = "GL m pthread dl rt X11",
	cmd = "mkdir -p build && cd build && cmake .. && make",
}

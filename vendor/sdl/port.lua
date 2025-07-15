return {
	includes = "include",
	staticLibs = "build/*.a",
	sysLibs = "m dl pthread X11",
	cmd =
	"mkdir -p build && cd build && cmake ..  -DCMAKE_BUILD_TYPE=Release -DSDL_STATIC=ON -DSDL_SHARED=OFF -DSDL_TEST=OFF -DCMAKE_POSITION_INDEPENDENT_CODE=ON -G Ninja && ninja"
}

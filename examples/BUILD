load(
    "@rules_stark//stark:defs.bzl",
    "stark_binary",
    "stark_module",
    "stark_test",
)

stark_binary(
    name = "clock",
    srcs = glob(["clock/src/*.st"]),
    deps = [
        "//stdmods:time",
    ],
)

stark_binary(
    name = "httpdownload",
    srcs = glob(["httpdownload/src/*.st"]),
    deps = [
        "//stdmods:http",
        "//stdmods:fs",
    ],
    linkopts = [
        "-lcurl",
    ],
)

stark_binary(
    name = "projectgen",
    srcs = glob(["projectgen/src/*.st"]),
    deps = [
        "//stdmods:fs",
    ],
)

stark_binary(
    name = "readfile",
    srcs = glob(["readfile/src/*.st"]),
    deps = [
        "//stdmods:fs"
    ],
)

stark_binary(
    name = "jsonbench",
    srcs = glob(["jsonbench/src/*.st"]),
    deps = [
        "//stdmods:json",
        "//stdmods:str",
        "//stdmods:fs",
        "//stdmods:http"
    ],
    linkopts = [
        "-lcurl",
    ],
)

stark_binary(
    name = "bench",
    srcs = glob(["bench/src/*.st"]),
    deps = [
        "//stdmods:perf",
        "//stdmods:str",
        "//stdmods:fs"
    ],
)


stark_binary(
    name = "ui",
    srcs = glob(["ui/src/*.st"]),
    deps = [
         "//stdmods:gfx"
    ],
    linkopts = [
        #"-lGLEW",
        #"-L/usr/local/Cellar/glfw/3.3.4/lib",
        #"-L/usr/local/lib",
        #"-lglfw",
        #"-framework OpenGL",
        
        "-l SDL2-2.0.0",
    ],
)
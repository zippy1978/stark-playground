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
        "//stdmods:fs",
        "//stdmods:json",
    ],
)


stark_binary(
    name = "gfxdemo",
    srcs = glob(["gfxdemo/src/*.st"]),
    deps = [
         "//stdmods:gfx"
    ],
    
    linkopts = [
        "-I/usr/local/Cellar/allegro/5.2.7.0/include",
        "-L/usr/local/Cellar/allegro/5.2.7.0/lib",
        "-lallegro_font",
        "-lallegro_image",
        "-lallegro",
    ],
)
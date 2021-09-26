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
    name = "readjson",
    srcs = glob(["readjson/src/*.st"]),
    deps = [
        "//stdmods:json",
        "//stdmods:str"
    ],
)
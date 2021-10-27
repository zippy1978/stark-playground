load(
    "@rules_stark//stark:defs.bzl",
    "stark_clang_module",
    "stark_module",
    "stark_test",
)

stark_module(
    name = "fs",
    srcs = glob(["fs/src/*.st"]),
    visibility = ["//visibility:public"],
)

stark_module(
    name = "time",
    srcs = glob(["time/src/*.st"]),
    visibility = ["//visibility:public"],
)
stark_test(
    name = "time_tests",
    srcs = glob(["time/tests/*.test.st"]),
    deps = [
        ":time",
    ],
)

stark_module(
    name = "str",
    srcs = glob(["str/src/*.st"]),
    visibility = ["//visibility:public"],
)
stark_test(
    name = "str_tests",
    srcs = glob(["str/tests/*.test.st"]),
    deps = [
        ":str",
    ],
)

stark_module(
    name = "perf",
    srcs = glob(["perf/src/*.st"]),
    visibility = ["//visibility:public"]
)
stark_test(
    name = "perf_tests",
    srcs = glob(["perf/tests/*.test.st"]),
    deps = [
        ":perf",
        ":str",
    ],
)

stark_module(
    name = "json",
    srcs = glob(["json/src/*.st"]),
    visibility = ["//visibility:public"],
    deps = [
        ":str",
    ],
)
stark_test(
    name = "json_tests",
    srcs = glob(["json/tests/*.test.st"]),
    deps = [
        ":json",
    ],
)

stark_module(
    name = "http",
    srcs = glob(["http/src/*.st"]),
    visibility = ["//visibility:public"],
    deps = [
        ":fs",
    ],
)

stark_clang_module(
    name = "_allegro5",
    srcs = glob(["_allegro5/src/*.c"]),
    hdr = "_allegro5/src/bridge.sth",
)

stark_module(
    name = "gfx",
    srcs = glob(["gfx/src/*.st"]),
    visibility = ["//visibility:public"],
    deps = [
        ":fs",
        "_allegro5",
    ],
)

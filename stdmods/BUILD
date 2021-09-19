load(
    "@rules_stark//stark:defs.bzl",
    "stark_binary",
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
    name = "json",
    srcs = glob(["json/src/*.st"]),
    visibility = ["//visibility:public"],
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
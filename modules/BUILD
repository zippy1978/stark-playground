load(
    "@rules_stark//stark:defs.bzl",
    "stark_binary",
    "stark_module",
    "stark_test",
)

stark_module(
    name = "fs",
    srcs = ["src/fs.st"],
    visibility = ["//visibility:public"],
)

stark_module(
    name = "time",
    srcs = ["src/time.st"],
    visibility = ["//visibility:public"],
)

stark_module(
    name = "http",
    srcs = ["src/http.st"],
    visibility = ["//visibility:public"],
    deps = [
        ":fs",
    ],
)
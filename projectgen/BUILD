load("//stark-bazel:stark.bzl", "stark_binary")

stark_binary(
    name = "main",
    srcs = glob(["src/*.st"]),
    deps = [
        "//modules:str",
        "//modules:fs",
    ],
)

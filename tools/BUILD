load(
    "@rules_stark//stark:defs.bzl",
    "stark_binary",
    "stark_module",
    "stark_test",
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

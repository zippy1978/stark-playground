workspace(name = "stark-playground")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
    name = "rules_stark",
    strip_prefix = "rules_stark-main",
    urls = ["https://github.com/zippy1978/rules_stark/archive/refs/heads/main.zip"],
)

load(
    "@rules_stark//stark:deps.bzl", 
    "stark_rules_dependencies",
    "stark_download", 
)

stark_rules_dependencies()

stark_download(
    name = "stark_darwin_x86_64",
    arch = "x86_64",
    os = "Darwin",
    sha256 = "",
    urls = ["https://github.com/zippy1978/stark/releases/download/0.0.1-SNAPSHOT/Stark-Darwin-x86_64-0.0.1-SNAPSHOT.zip"],
)

stark_download(
    name = "stark_linux_x86_64",
    arch = "x86_64",
    os = "Linux",
    sha256 = "",
    urls = ["https://github.com/zippy1978/stark/releases/download/0.0.1-SNAPSHOT/Stark-Linux-x86_64-0.0.1-SNAPSHOT.zip"],
)

register_toolchains(
    "@stark_darwin_x86_64//:toolchain",
    "@stark_linux_x86_64//:toolchain",
)

# LLVM 

# BAZEL_TOOLCHAIN_TAG = "0.6.3"
# BAZEL_TOOLCHAIN_SHA = "da607faed78c4cb5a5637ef74a36fdd2286f85ca5192222c4664efec2d529bb8"

# http_archive(
#     name = "com_grail_bazel_toolchain",
#     sha256 = BAZEL_TOOLCHAIN_SHA,
#     strip_prefix = "bazel-toolchain-{tag}".format(tag = BAZEL_TOOLCHAIN_TAG),
#     canonical_id = BAZEL_TOOLCHAIN_TAG,
#     url = "https://github.com/grailbio/bazel-toolchain/archive/{tag}.tar.gz".format(tag = BAZEL_TOOLCHAIN_TAG),
# )

# load("@com_grail_bazel_toolchain//toolchain:deps.bzl", "bazel_toolchain_dependencies")

# bazel_toolchain_dependencies()

# load("@com_grail_bazel_toolchain//toolchain:rules.bzl", "llvm_toolchain")

# llvm_toolchain(
#     name = "llvm_toolchain",
#     llvm_version = "13.0.0",
# )

# load("@llvm_toolchain//:toolchains.bzl", "llvm_register_toolchains")

# llvm_register_toolchains()
workspace(
    name = "bazel-zig-cc",
)

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "dd926a88a564a9246713a9c00b35315f54cbd46b31a26d5d8fb264c07045f05d",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.38.1/rules_go-v0.38.1.zip",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.38.1/rules_go-v0.38.1.zip",
    ],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

http_archive(
    name = "bazel_gazelle",
    sha256 = "ecba0f04f96b4960a5b250c8e8eeec42281035970aa8852dda73098274d14a1d",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.29.0/bazel-gazelle-v0.29.0.tar.gz",
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.29.0/bazel-gazelle-v0.29.0.tar.gz",
    ],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_download_sdk", "go_register_toolchains", "go_rules_dependencies")
load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

go_rules_dependencies()

# use latest stable.
go_download_sdk(
    name = "go_sdk",
    version = "1.20",
)

go_register_toolchains()

load("//:repositories.bzl", "go_repositories")

# gazelle:repository_macro repositories.bzl%go_repositories
go_repositories()

gazelle_dependencies(go_repository_default_config = "@//:WORKSPACE")

load(
    "//toolchain:defs.bzl",
    zig_toolchains = "toolchains",
)

zig_toolchains()

register_toolchains(
    # if no `--platform` is specified, these toolchains will be used for
    # (linux,darwin,windows)x(amd64,arm64,riscv64,armv6)
    "@zig_sdk//toolchain:linux_amd64_gnu.2.19",
    "@zig_sdk//toolchain:linux_arm64_gnu.2.28",
    "@zig_sdk//toolchain:linux_armv6_gnu.2.28",
    "@zig_sdk//toolchain:linux_riscv64_gnu.2.28",
    "@zig_sdk//toolchain:darwin_amd64",
    "@zig_sdk//toolchain:darwin_arm64",
    "@zig_sdk//toolchain:windows_amd64",
    "@zig_sdk//toolchain:windows_arm64",

    # amd64 toolchains for libc-aware platforms:
    "@zig_sdk//libc_aware/toolchain:linux_amd64_gnu.2.19",
    "@zig_sdk//libc_aware/toolchain:linux_amd64_gnu.2.28",
    "@zig_sdk//libc_aware/toolchain:linux_amd64_gnu.2.31",
    "@zig_sdk//libc_aware/toolchain:linux_amd64_musl",
    # arm64 toolchains for libc-aware platforms:
    "@zig_sdk//libc_aware/toolchain:linux_arm64_gnu.2.28",
    "@zig_sdk//libc_aware/toolchain:linux_arm64_musl",
    # armv6 toolchains for libc-aware platforms:
    "@zig_sdk//libc_aware/toolchain:linux_armv6_gnu.2.28",
    "@zig_sdk//libc_aware/toolchain:linux_armv6_musl",
    # riscv64 toolchains for libc-aware platforms:
    "@zig_sdk//libc_aware/toolchain:linux_riscv64_gnu.2.28",
    "@zig_sdk//libc_aware/toolchain:linux_riscv64_musl",
)

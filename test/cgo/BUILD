load("@io_bazel_rules_go//go:def.bzl", "go_library", "go_test")
load("//rules:rules_go.bzl", "go_binary")
load("@bazel-zig-cc//rules:platform.bzl", "platform_binary", "platform_test")

go_library(
    name = "cgo_lib",
    srcs = ["cgo.go"],
    cgo = True,
    importpath = "git.sr.ht/~motiejus/bazel-zig-cc/test/cgo",
    visibility = ["//visibility:private"],
)

go_test(
    name = "cgo_test",
    srcs = ["cgo_test.go"],
    embed = [":cgo_lib"],
)

go_binary(
    name = "cgo",
    embed = [":cgo_lib"],
    visibility = ["//visibility:public"],
)

[
    platform_binary(
        name = "cgo_{}".format(name),
        src = "cgo",
        platform = platform,
    )
    for name, platform in [
        ("linux_amd64_musl", "//libc_aware/platform:linux_amd64_musl"),
        ("linux_amd64_gnu.2.19", "//libc_aware/platform:linux_amd64_gnu.2.19"),
        ("linux_arm64_musl", "//libc_aware/platform:linux_arm64_musl"),
        ("linux_arm64_gnu.2.28", "//libc_aware/platform:linux_arm64_gnu.2.28"),
        ("linux_arm_gnueabihf.2.28", "//libc_aware/platform:linux_arm_gnueabihf.2.28"),
        ("darwin_amd64", "//platform:darwin_amd64"),
    ]
]

[
    platform_test(
        name = "cgo_test_{}".format(name),
        src = "cgo_test",
        env = {"QEMU_LD_PREFIX": "/usr/aarch64-linux-gnu"} if is_arm64 else {"QEMU_LD_PREFIX": "/usr/arm-linux-gnueabihf"} if is_armv6 else {},
        platform = platform,
        run_under = "qemu-aarch64-static" if is_arm64 else "qemu-arm-static" if is_armv6 else "",
    )
    for name, platform, is_arm64, is_armv6 in [
        ("linux_amd64_musl", "//libc_aware/platform:linux_amd64_musl", False, False),
        ("linux_amd64_gnu.2.19", "//libc_aware/platform:linux_amd64_gnu.2.19", False, False),
        ("linux_arm64_musl", "//libc_aware/platform:linux_arm64_musl", True, False),
        ("linux_arm64_gnu.2.28", "//libc_aware/platform:linux_arm64_gnu.2.28", True, False),
        ("linux_arm_gnueabihf.2.28", "//libc_aware/platform:linux_arm_gnueabihf.2.28", False, True),
    ]
]

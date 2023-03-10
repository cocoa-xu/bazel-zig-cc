load("@bazel-zig-cc//rules:platform.bzl", "platform_binary")

cc_binary(
    name = "which_libc",
    srcs = ["main.c"],
    target_compatible_with = [
        "@platforms//os:linux",
    ],
)

[
    (
        platform_binary(
            name = "which_libc_{}".format(name),
            src = "which_libc",
            env = {"QEMU_LD_PREFIX": "/usr/aarch64-linux-gnu"} if "arm64" in name else {},
            platform = platform,
            run_under = "qemu-aarch64-static" if "arm64" in name else "",
        ),
        sh_test(
            name = "test_libc_{}".format(name),
            srcs = ["test.sh"],
            data = ["which_libc_{}".format(name)],
            env = {
                "WANT": want,
                "BINARY": "$(location which_libc_{})".format(name),
            },
        ),
    )
    for name, platform, want in [
        ("linux_amd64_musl", "//libc_aware/platform:linux_amd64_musl", "non-glibc"),
        ("linux_amd64_gnu.2.19", "//libc_aware/platform:linux_amd64_gnu.2.19", "glibc_2.19"),
        ("linux_amd64_gnu.2.28", "//libc_aware/platform:linux_amd64_gnu.2.28", "glibc_2.28"),
        ("linux_arm64_musl", "//libc_aware/platform:linux_arm64_musl", "non-glibc"),
        ("linux_arm_musleabihf", "//libc_aware/platform:linux_arm_musleabihf", "non-glibc"),
        ("linux_amd64", "//platform:linux_amd64", "glibc_2.19"),
        ("linux_arm64", "//platform:linux_arm64", "glibc_2.28"),
        ("linux_arm", "//platform:linux_arm", "glibc_2.28"),
    ]
]

[
    (
        platform_binary(
            name = "which_libc_{}".format(name),
            src = "which_libc",
            env = {"QEMU_LD_PREFIX": "/usr/riscv64-linux-gnu"} if "riscv64" in name else {},
            platform = platform,
            run_under = "qemu-riscv64-static" if "riscv64" in name else "",
        ),
        sh_test(
            name = "test_libc_{}".format(name),
            srcs = ["test.sh"],
            data = ["which_libc_{}".format(name)],
            env = {
                "WANT": want,
                "BINARY": "$(location which_libc_{})".format(name),
            },
        ),
    )
    for name, platform, want in [
        ("linux_amd64_musl", "//libc_aware/platform:linux_amd64_musl", "non-glibc"),
        ("linux_amd64_gnu.2.19", "//libc_aware/platform:linux_amd64_gnu.2.19", "glibc_2.19"),
        ("linux_amd64_gnu.2.28", "//libc_aware/platform:linux_amd64_gnu.2.28", "glibc_2.28"),
        ("linux_arm64_musl", "//libc_aware/platform:linux_arm64_musl", "non-glibc"),
        ("linux_arm_musleabihf", "//libc_aware/platform:linux_arm_musleabihf", "non-glibc"),
        ("linux_amd64", "//platform:linux_amd64", "glibc_2.19"),
        ("linux_arm64", "//platform:linux_arm64", "glibc_2.28"),
        ("linux_arm", "//platform:linux_arm", "glibc_2.28"),
    ]
]

[
    (
        platform_binary(
            name = "which_libc_{}".format(name),
            src = "which_libc",
            env = {"QEMU_LD_PREFIX": "/usr/arm-linux-gnueabihf"} if "linux_arm" == name else {},
            platform = platform,
            run_under = "qemu-arm-static" if "linux_arm" == name else "",
        ),
        sh_test(
            name = "test_libc_{}".format(name),
            srcs = ["test.sh"],
            data = ["which_libc_{}".format(name)],
            env = {
                "WANT": want,
                "BINARY": "$(location which_libc_{})".format(name),
            },
        ),
    )
    for name, platform, want in [
        ("linux_amd64_musl", "//libc_aware/platform:linux_amd64_musl", "non-glibc"),
        ("linux_amd64_gnu.2.19", "//libc_aware/platform:linux_amd64_gnu.2.19", "glibc_2.19"),
        ("linux_amd64_gnu.2.28", "//libc_aware/platform:linux_amd64_gnu.2.28", "glibc_2.28"),
        ("linux_arm64_musl", "//libc_aware/platform:linux_arm64_musl", "non-glibc"),
        ("linux_arm_musleabihf", "//libc_aware/platform:linux_arm_musleabihf", "non-glibc"),
        ("linux_amd64", "//platform:linux_amd64", "glibc_2.19"),
        ("linux_arm64", "//platform:linux_arm64", "glibc_2.28"),
        ("linux_arm", "//platform:linux_arm", "glibc_2.28"),
    ]
]

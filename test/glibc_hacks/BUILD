# Copyright 2023 Uber Technologies, Inc.
# Licensed under the Apache License, Version 2.0

load("@bazel-zig-cc//rules:platform.bzl", "platform_binary")

cc_binary(
    name = "main",
    srcs = ["main.c"],
)

[
    (
        platform_binary(
            name = "main_{}".format(name),
            src = "main",
            platform = platform,
        ),
    )
    for name, platform in [
        ("linux_amd64_musl", "//libc_aware/platform:linux_amd64_musl"),
        ("linux_amd64_gnu.2.19", "//libc_aware/platform:linux_amd64_gnu.2.19"),
        ("linux_amd64_gnu.2.28", "//libc_aware/platform:linux_amd64_gnu.2.28"),
        ("linux_arm_gnueabihf.2.28", "//libc_aware/platform:linux_arm_gnueabihf.2.28"),
        ("linux_arm64_musl", "//libc_aware/platform:linux_arm64_musl"),
        ("linux_riscv64_musl", "//libc_aware/platform:linux_riscv64_musl"),
        ("linux_arm_musleabihf", "//libc_aware/platform:linux_arm_musleabihf"),
    ]
]

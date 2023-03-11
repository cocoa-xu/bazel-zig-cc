# Copyright 2023 Uber Technologies, Inc.
# Licensed under the Apache License, Version 2.0

load("@bazel-zig-cc//toolchain/private:defs.bzl", "LIBCS")
load("@bazel-zig-cc//toolchain/private:defs.bzl", "LIBCS_EABIHF")

def declare_libcs():
    for libc in LIBCS:
        native.constraint_value(
            name = libc,
            constraint_setting = "variant",
        )

    for libc in LIBCS_EABIHF:
        native.constraint_value(
            name = libc,
            constraint_setting = "variant",
        )

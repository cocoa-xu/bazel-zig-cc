load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "feature",
    "flag_group",
    "flag_set",
    "tool",
    "tool_path",
)

all_link_actions = [
    ACTION_NAMES.cpp_link_executable,
    ACTION_NAMES.cpp_link_dynamic_library,
    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
]

dynamic_library_link_actions = [
    ACTION_NAMES.cpp_link_dynamic_library,
    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
]

compile_and_link_actions = [
    ACTION_NAMES.c_compile,
    ACTION_NAMES.cpp_compile,
]

rest_compile_actions = [
    ACTION_NAMES.assemble,
    ACTION_NAMES.cc_flags_make_variable,
    ACTION_NAMES.clif_match,
    ACTION_NAMES.cpp_header_parsing,
    ACTION_NAMES.cpp_module_codegen,
    ACTION_NAMES.cpp_module_compile,
    ACTION_NAMES.linkstamp_compile,
    ACTION_NAMES.lto_backend,
    ACTION_NAMES.preprocess_assemble,
]

def _zig_cc_toolchain_config_impl(ctx):
    compiler_flags = [
        "-I" + d
        for d in ctx.attr.cxx_builtin_include_directories
    ] + [
        "-target",
        ctx.attr.target + ctx.attr.target_suffix,
        "-no-canonical-prefixes",
        "-Wno-builtin-macro-redefined",
        "-D__DATE__=\"redacted\"",
        "-D__TIMESTAMP__=\"redacted\"",
        "-D__TIME__=\"redacted\"",
    ]
    no_gc_sections = ["-Wl,--no-gc-sections"]

    compile_and_link_flags = feature(
        name = "compile_and_link_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = compile_and_link_actions,
                flag_groups = [
                    flag_group(flags = no_gc_sections),
                    flag_group(flags = compiler_flags + ctx.attr.copts),
                ],
            ),
        ],
    )

    rest_compile_flags = feature(
        name = "rest_compile_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = rest_compile_actions,
                flag_groups = [
                    flag_group(flags = compiler_flags + ctx.attr.copts),
                ],
            ),
        ],
    )

    if ctx.attr.dynamic_library_linkopts:
        dynamic_library_flag_sets = [
            flag_set(
                actions = dynamic_library_link_actions,
                flag_groups = [flag_group(flags = ctx.attr.dynamic_library_linkopts)],
            ),
        ]
    else:
        dynamic_library_flag_sets = []

    default_linker_flags = feature(
        name = "default_linker_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = all_link_actions,
                flag_groups = [
                    flag_group(
                        flags = ["-target", ctx.attr.target] +
                                no_gc_sections +
                                ctx.attr.linkopts,
                    ),
                ],
            ),
        ] + dynamic_library_flag_sets,
    )

    features = [
        compile_and_link_flags,
        rest_compile_flags,
        default_linker_flags,
    ]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        features = features,
        toolchain_identifier = "%s-toolchain" % ctx.attr.target,
        host_system_name = "local",
        target_system_name = ctx.attr.target_system_name,
        target_cpu = ctx.attr.target_cpu,
        target_libc = ctx.attr.target_libc,
        compiler = ctx.attr.compiler,
        abi_version = ctx.attr.abi_version,
        abi_libc_version = ctx.attr.abi_libc_version,
        tool_paths = [
            tool_path(name = name, path = path)
            for name, path in ctx.attr.tool_paths.items()
        ],
        cxx_builtin_include_directories = ctx.attr.cxx_builtin_include_directories,
    )

zig_cc_toolchain_config = rule(
    implementation = _zig_cc_toolchain_config_impl,
    attrs = {
        "cxx_builtin_include_directories": attr.string_list(),
        "linkopts": attr.string_list(),
        "dynamic_library_linkopts": attr.string_list(),
        "copts": attr.string_list(),
        "tool_paths": attr.string_dict(),
        "target": attr.string(),
        "target_system_name": attr.string(),
        "target_cpu": attr.string(),
        "target_libc": attr.string(),
        "target_suffix": attr.string(),
        "compiler": attr.string(),
        "abi_version": attr.string(),
        "abi_libc_version": attr.string(),
    },
    provides = [CcToolchainConfigInfo],
)

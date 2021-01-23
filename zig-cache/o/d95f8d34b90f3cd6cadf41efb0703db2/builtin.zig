usingnamespace @import("std").builtin;
/// Deprecated
pub const arch = Target.current.cpu.arch;
/// Deprecated
pub const endian = Target.current.cpu.arch.endian();

/// Zig version. When writing code that supports multiple versions of Zig, prefer
/// feature detection (i.e. with `@hasDecl` or `@hasField`) over version checks.
pub const zig_version = try @import("std").SemanticVersion.parse("0.8.0-dev.1039+bea791b63");

pub const output_mode = OutputMode.Exe;
pub const link_mode = LinkMode.Dynamic;
pub const is_test = false;
pub const single_threaded = false;
pub const abi = Abi.gnu;
pub const cpu: Cpu = Cpu{
    .arch = .x86_64,
    .model = &Target.x86.cpu.bdver2,
    .features = Target.x86.featureSet(&[_]Target.x86.Feature{
        .@"64bit",
        .@"aes",
        .@"avx",
        .@"bmi",
        .@"branchfusion",
        .@"cmov",
        .@"cx16",
        .@"cx8",
        .@"f16c",
        .@"fast_11bytenop",
        .@"fast_bextr",
        .@"fast_scalar_shift_masks",
        .@"fma",
        .@"fma4",
        .@"fxsr",
        .@"lwp",
        .@"lzcnt",
        .@"mmx",
        .@"nopl",
        .@"pclmul",
        .@"popcnt",
        .@"prfchw",
        .@"sahf",
        .@"slow_shld",
        .@"sse",
        .@"sse2",
        .@"sse3",
        .@"sse4_1",
        .@"sse4_2",
        .@"sse4a",
        .@"ssse3",
        .@"tbm",
        .@"vzeroupper",
        .@"x87",
        .@"xop",
        .@"xsave",
    }),
};
pub const os = Os{
    .tag = .linux,
    .version_range = .{ .linux = .{
        .range = .{
            .min = .{
                .major = 5,
                .minor = 10,
                .patch = 9,
            },
            .max = .{
                .major = 5,
                .minor = 10,
                .patch = 9,
            },
        },
        .glibc = .{
            .major = 2,
            .minor = 17,
            .patch = 0,
        },
    }},
};
pub const object_format = ObjectFormat.elf;
pub const mode = Mode.ReleaseSafe;
pub const link_libc = true;
pub const link_libcpp = false;
pub const have_error_return_tracing = false;
pub const valgrind_support = false;
pub const position_independent_code = true;
pub const position_independent_executable = false;
pub const strip_debug_info = true;
pub const code_model = CodeModel.default;

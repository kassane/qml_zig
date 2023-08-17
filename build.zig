const std = @import("std");
const GitRepoStep = @import("GitRepoStep.zig");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardOptimizeOption(.{});

    // Note: If it is not necessary to compile DOtherSide library, please comment on this line.
    const cmake = cmakeBuild(b);
    const cmake_step = b.step("cmake", "Run cmake build");
    cmake_step.dependOn(&cmake.step);

    // Original examples
    try makeExample(b, .{
        .optimize = mode,
        .target = target,
        .path = "examples/animated.zig",
    });
    try makeExample(b, .{
        .optimize = mode,
        .target = target,
        .path = "examples/hello.zig",
    });

    // More examples
    try makeExample(b, .{
        .optimize = mode,
        .target = target,
        .path = "examples/button.zig",
    });

    // Copypasta from the Go QML eamples https://github.com/go-qml/qml/tree/v1/examples
    try makeExample(b, .{
        .optimize = mode,
        .target = target,
        .path = "examples/particle.zig",
    });
    try makeExample(b, .{
        .optimize = mode,
        .target = target,
        .path = "examples/layouts.zig",
    });
    try makeExample(b, .{
        .optimize = mode,
        .target = target,
        .path = "examples/splitview.zig",
    });
    try makeExample(b, .{
        .optimize = mode,
        .target = target,
        .path = "examples/tableview.zig",
    });

    // Cloned simple examples from the Qml doco
    try makeExample(b, .{
        .optimize = mode,
        .target = target,
        .path = "examples/cells.zig",
    });
}

fn makeExample(b: *std.Build, src: BuildInfo) !void {
    const example = b.addExecutable(.{
        .name = src.filename(),
        .root_source_file = .{ .path = src.path },
        .optimize = src.optimize,
        .target = src.target,
    });

    //Strip file
    if (src.optimize != .Debug) {
        example.strip = true;
    }

    // Module
    const Qt = b.createModule(.{
        .source_file = .{ .path = "src/Qt.zig" },
    });

    example.addModule("Qt", Qt);
    example.addLibraryPath(.{ .path = "zig-cache/lib" });

    if (example.target.isWindows()) {
        example.want_lto = false;
        example.linkSystemLibraryName("DOtherSide.dll");
    } else example.linkSystemLibrary("DOtherSide");
    example.linkLibC();

    b.installArtifact(example);

    const run_cmd = b.addRunArtifact(example);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    var descr = b.fmt("Run the {s} example", .{src.filename()});
    const run_step = b.step(src.filename(), descr);
    run_step.dependOn(&run_cmd.step);
}

fn cmakeBuild(b: *std.Build) *std.Build.Step.Run {
    const repo = GitRepoStep.create(b, .{
        .url = "https://github.com/filcuc/dotherside.git",
        .branch = "master",
        .sha = "244a9d62cb51519ca45fe2e69d77ec965f190fbb",
        .fetch_enabled = true,
    });

    //CMake builds - DOtherSide build
    const DOtherSide_configure = b.addSystemCommand(&[_][]const u8{
        "cmake",
        "-B",
        "zig-cache",
        "-S",
        "dep/dotherside.git",
        "-DCMAKE_BUILD_TYPE=RelMinSize",
    });
    const DOtherSide_build = b.addSystemCommand(&[_][]const u8{
        "cmake",
        "--build",
        "zig-cache",
        "--parallel",
    });

    DOtherSide_configure.step.dependOn(&repo.step);
    DOtherSide_build.step.dependOn(&DOtherSide_configure.step);
    return DOtherSide_build;
}

const BuildInfo = struct {
    path: []const u8,
    target: std.zig.CrossTarget,
    optimize: std.builtin.OptimizeMode,

    fn filename(self: BuildInfo) []const u8 {
        var split = std.mem.splitSequence(u8, std.fs.path.basename(self.path), ".");
        return split.first();
    }
};

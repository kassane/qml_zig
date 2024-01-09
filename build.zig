const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardOptimizeOption(.{});

    // Module
    _ = b.addModule("Qt", .{
        .root_source_file = .{
            .path = "src/Qt.zig",
        },
    });

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
        example.root_module.strip = true;
    }

    example.root_module.addImport("Qt", b.modules.get("Qt").?);
    example.addLibraryPath(.{ .path = "zig-cache/lib" });

    if (example.rootModuleTarget().os.tag == .windows)
        example.want_lto = false;
    example.linkSystemLibrary("DOtherSide");
    example.linkLibC();

    b.installArtifact(example);

    const run_cmd = b.addRunArtifact(example);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const descr = b.fmt("Run the {s} example", .{src.filename()});
    const run_step = b.step(src.filename(), descr);
    run_step.dependOn(&run_cmd.step);
}

pub fn cmakeBuild(b: *std.Build) *std.Build.Step.Run {
    const dotherside = b.dependency("dotherside", .{}).path("").getPath(b);

    // CMake builds - DOtherSide build
    const DOtherSide_configure = b.addSystemCommand(&[_][]const u8{
        "cmake",
        "-B",
        "zig-cache",
        "-S",
        dotherside,
        "-DCMAKE_BUILD_TYPE=RelMinSize",
    });
    const DOtherSide_build = b.addSystemCommand(&[_][]const u8{
        "cmake",
        "--build",
        "zig-cache",
        "--parallel",
    });

    DOtherSide_build.step.dependOn(&DOtherSide_configure.step);
    return DOtherSide_build;
}

const BuildInfo = struct {
    path: []const u8,
    target: std.Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,

    fn filename(self: BuildInfo) []const u8 {
        var split = std.mem.splitSequence(u8, std.fs.path.basename(self.path), ".");
        return split.first();
    }
};

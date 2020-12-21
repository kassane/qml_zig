//const std = @import("std");
const ds = @import("./DOtherSide.zig");

const app = @embedFile("../examples/hello.qml"); //Compile-time readfile

pub fn main() void {
    ds.dos_qapplication_create();
    const engine: *ds.DosQQmlApplicationEngine = ds.dos_qqmlapplicationengine_create().?;
    ds.dos_qqmlapplicationengine_load_data(engine, app);

    ds.dos_qapplication_exec();

    ds.dos_qqmlapplicationengine_delete(engine);
    ds.dos_qapplication_delete();
}

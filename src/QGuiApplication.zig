const dos = @import("DOtherSide.zig");

pub const QGuiApplication = struct {
    pub fn init() void {
        dos.dos_qguiapplication_create();
    }

    pub fn exec() void {
        dos.dos_qguiapplication_exec();
    }

    pub fn quit() void {
        dos.dos_qguiapplication_quit();
    }

    pub fn delete() void {
        dos.dos_qguiapplication_delete();
    }
};

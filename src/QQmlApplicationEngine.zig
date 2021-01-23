const dos = @import("DOtherSide.zig");
const QUrl = @import("QUrl.zig").QUrl;
const QQmlContext = @import("QQmlContext.zig").QQmlContext;

pub const QQmlApplicationEngine = struct {
    vptr: ?*dos.DosQQmlApplicationEngine,

    pub fn create() QQmlApplicationEngine {
        return QQmlApplicationEngine{ .vptr = dos.dos_qqmlapplicationengine_create() };
    }

    pub fn delete(self: QQmlApplicationEngine) void {
        dos.dos_qqmlapplicationengine_delete(self.vptr);
    }

    pub fn rootContext(self: QQmlApplicationEngine) QQmlContext {
        return QQmlContext{ .vptr = dos.dos_qqmlapplicationengine_context(self.vptr) };
    }

    pub fn load(self: QQmlApplicationEngine, name: [*c]const u8) void {
        dos.dos_qqmlapplicationengine_load(self.vptr, name);
    }

    pub fn loadData(self: QQmlApplicationEngine, data: [*c]const u8) void {
        dos.dos_qqmlapplicationengine_load_data(self.vptr, data);
    }

    pub fn loadUrl(self: QQmlApplicationEngine, url: QUrl) void {
        dos.dos_qqmlapplicationengine_load_url(self.vptr, url.vptr);
    }

    pub fn addImportPath(self: QQmlApplicationEngine, path: [*c]const u8) void {
        dos.dos_qqmlapplicationengine_add_import_path(self.vptr, path);
    }

    // TODO: addImageProvider
};

const dos = @import("DOtherSide.zig");
const QVariant = @import("QVariant.zig").QVariant;

pub const QQmlContext = struct {
    vptr: ?*dos.DosQQmlApplicationEngine,

    pub fn setContextProperty(self: QQmlContext, name: [*c]const u8, variant: QVariant) void {
        dos.dos_qqmlcontext_setcontextproperty(self.vptr, name, variant.vptr);
    }

    pub fn baseUrl(self: QQmlContext) [*c]u8 {
        return dos.dos_qqmlcontext_baseUrl(self.vptr);
    }
};

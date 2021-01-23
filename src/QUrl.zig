const dos = @import("DOtherSide.zig");

pub const QUrl = struct {
    vptr: ?*dos.DosQUrl,

    pub fn create(url: [*c]const u8) QUrl {
        return QUrl{
            .vptr = dos.dos_qurl_create(url, 0),
        };
    }

    pub fn delete(self: QUrl) void {
        dos.dos_qurl_delete(self.vptr);
    }

    pub fn toString(self: QUrl) [*c]u8 {
        return dos.dos_qurl_to_string(self.vptr);
    }

    pub fn isValid(self: QUrl) bool {
        return dos.dos_qurl_isValid(self.vptr);
    }
};

const expect = @import("std").testing.expect;

test "QUrl intialization" {
    var url = QUrl.create("file://test/path.qml");
    defer url.delete();

    expect(url.isValid());
}

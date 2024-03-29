const dos = @import("DOtherSide.zig");

//TODO: add rest of supported types
pub const QVariant = struct {
    vptr: ?*dos.dos_type.DosQVariant,

    pub fn create(value: anytype) QVariant {
        const vptr = switch (@typeInfo(@TypeOf(value))) {
            .Null => dos.dos_qvariant_create(),
            .Pointer => dos.dos_qvariant_create_string(value),
            .Int => dos.dos_qvariant_create_int(@as(c_int, @intCast(value))),
            .Float => |float| switch (float.bits) {
                32 => dos.dos_qvariant_create_float(value),
                64 => dos.dos_qvariant_create_double(value),
                else => @compileError("Unsupported type '" ++ @typeName(value) ++ "'"),
            },
            .Bool => dos.dos_qvariant_create_bool(value),
            @typeInfo(QVariant) => dos.dos_qvariant_create_qvariant(value.vptr),
            else => @compileError("Unsupported type '" ++ @typeName(value) ++ "'"),
        };
        return QVariant{ .vptr = vptr };
    }

    pub fn wrap(vptr: ?*dos.DosQVariant) QVariant {
        return QVariant{ .vptr = vptr };
    }

    pub fn delete(self: QVariant) void {
        dos.dos_qvariant_delete(self.vptr);
    }

    pub fn setValue(self: QVariant, value: anytype) void {
        switch (@typeInfo(@TypeOf(value))) {
            .Null => @compileError("Cannot set variant to null"),
            .Pointer => dos.dos_qvariant_setString(self.vptr, value),
            .Int => dos.dos_qvariant_setInt(self.vptr, @as(c_int, @intCast(value))),
            .Float => |float| switch (float.bits) {
                32 => dos.dos_qvariant_setFloat(value),
                64 => dos.dos_qvariant_setDouble(value),
                else => @compileError("Unsupported type '" ++ @typeName(value) ++ "'"),
            },
            .Bool => dos.dos_qvariant_setBool(self.vptr, value),
            else => @compileError("Unsupported type '" ++ @typeName(value) ++ "'"),
        }
    }

    pub fn getValue(self: QVariant, comptime T: type) T {
        return switch (@typeInfo(T)) {
            .Null => @compileError("Use isNull"),
            .Pointer => dos.dos_qvariant_toString(self.vptr),
            .Int => @as(T, @intCast(dos.dos_qvariant_toInt(self.vptr))),
            .Bool => dos.dos_qvariant_toBool(self.vptr),
            .Float => |float| switch (float.bits) {
                32 => dos.dos_qvariant_toFloat(self.vptr),
                64 => dos.dos_qvariant_toDouble(self.vptr),
                else => @compileError("Unsupported type '" ++ @typeName(T) ++ "'"),
            },
            else => @compileError("Unsupported type '" ++ @typeName(T) ++ "'"),
        };
    }

    pub fn isNull(self: QVariant) bool {
        return dos.dos_qvariant_isnull(self.vptr);
    }
};

const expect = @import("std").testing.expect;

const TEST_TYPES = .{
    true,
    @as(u32, 1),
    @as(f32, 2.37),
    @as(f64, 3.48),
};

test "QVariant initialization" {
    inline for (TEST_TYPES) |t| {
        var variant = QVariant.create(t);
        defer variant.delete();

        expect(variant.getValue(@TypeOf(t)) == t);
    }

    var nullVariant = QVariant.create(null);
    expect(nullVariant.isNull());
}

test "QVariant initialization from different QVariant" {
    inline for (TEST_TYPES) |t| {
        var variant = QVariant.create(t);
        defer variant.delete();

        var variantCopy = QVariant.create(variant);
        defer variantCopy.delete();

        expect(variantCopy.getValue(@TypeOf(t)) == t);
    }
}

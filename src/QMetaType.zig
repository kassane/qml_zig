pub const QMetaType = enum(c_int) {
    Unknown = 0,
    Bool = 1,
    Int = 2,
    Double = 6,
    String = 10,
    VoidStr = 31,
    Float = 38,
    QObject = 39,
    QVariant = 41,
    Void = 43,

    pub fn toQMetaType(comptime T: ?type) QMetaType {
        return switch (@typeInfo(T.?)) {
            .Int => QMetaType.Int,
            .Void => QMetaType.Void,
            .Pointer => QMetaType.VoidStr,
            //@hasField(T.?, "Q_OBJECT") => QMetaType.QObject,
            else => @compileError("Unsupported type: " ++ @typeName(T.?)),
        };
    }
};

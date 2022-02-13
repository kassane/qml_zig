pub const DosQVariant = anyopaque;
pub const DosQModelIndex = anyopaque;
pub const DosQAbstractItemModel = anyopaque;
pub const DosQAbstractListModel = anyopaque;
pub const DosQAbstractTableModel = anyopaque;
pub const DosQQmlApplicationEngine = anyopaque;
pub const DosQQuickView = anyopaque;
pub const DosQQmlContext = anyopaque;
pub const DosQHashIntQByteArray = anyopaque;
pub const DosQUrl = anyopaque;
pub const DosQMetaObject = anyopaque;
pub const DosQObject = anyopaque;
pub const DosQQuickImageProvider = anyopaque;
pub const DosPixmap = anyopaque;
pub const DosQPointer = anyopaque;
pub const RequestPixmapCallback = ?fn ([*c]const u8, [*c]c_int, [*c]c_int, c_int, c_int, ?*DosPixmap) callconv(.C) void;
pub const DObjectCallback = ?fn (?*anyopaque, ?*DosQVariant, c_int, [*c]?*DosQVariant) callconv(.C) void;
pub const RowCountCallback = ?fn (?*anyopaque, ?*const DosQModelIndex, [*c]c_int) callconv(.C) void;
pub const ColumnCountCallback = ?fn (?*anyopaque, ?*const DosQModelIndex, [*c]c_int) callconv(.C) void;
pub const DataCallback = ?fn (?*anyopaque, ?*const DosQModelIndex, c_int, ?*DosQVariant) callconv(.C) void;
pub const SetDataCallback = ?fn (?*anyopaque, ?*const DosQModelIndex, ?*const DosQVariant, c_int, [*c]bool) callconv(.C) void;
pub const RoleNamesCallback = ?fn (?*anyopaque, ?*DosQHashIntQByteArray) callconv(.C) void;
pub const FlagsCallback = ?fn (?*anyopaque, ?*const DosQModelIndex, [*c]c_int) callconv(.C) void;
pub const HeaderDataCallback = ?fn (?*anyopaque, c_int, c_int, c_int, ?*DosQVariant) callconv(.C) void;
pub const IndexCallback = ?fn (?*anyopaque, c_int, c_int, ?*const DosQModelIndex, ?*DosQModelIndex) callconv(.C) void;
pub const ParentCallback = ?fn (?*anyopaque, ?*const DosQModelIndex, ?*DosQModelIndex) callconv(.C) void;
pub const HasChildrenCallback = ?fn (?*anyopaque, ?*const DosQModelIndex, [*c]bool) callconv(.C) void;
pub const CanFetchMoreCallback = ?fn (?*anyopaque, ?*const DosQModelIndex, [*c]bool) callconv(.C) void;
pub const FetchMoreCallback = ?fn (?*anyopaque, ?*const DosQModelIndex) callconv(.C) void;
pub const CreateDObject = ?fn (c_int, ?*anyopaque, [*c]?*anyopaque, [*c]?*anyopaque) callconv(.C) void;
pub const DeleteDObject = ?fn (c_int, ?*anyopaque) callconv(.C) void;
pub const DosQVariantArray = extern struct {
    size: c_int,
    data: [*c]?*DosQVariant,
};
pub const QmlRegisterType = extern struct {
    major: c_int,
    minor: c_int,
    uri: [*c]const u8,
    qml: [*c]const u8,
    staticMetaObject: ?*DosQMetaObject,
    createDObject: CreateDObject,
    deleteDObject: DeleteDObject,
};
pub const ParameterDefinition = extern struct {
    name: [*c]const u8,
    metaType: c_int,
};
pub const SignalDefinition = extern struct {
    name: [*c]const u8,
    parametersCount: c_int,
    parameters: [*c]ParameterDefinition,
};
pub const SignalDefinitions = extern struct {
    count: c_int,
    definitions: [*c]SignalDefinition,
};
pub const SlotDefinition = extern struct {
    name: [*c]const u8,
    returnMetaType: c_int,
    parametersCount: c_int,
    parameters: [*c]ParameterDefinition,
};
pub const SlotDefinitions = extern struct {
    count: c_int,
    definitions: [*c]SlotDefinition,
};
pub const PropertyDefinition = extern struct {
    name: [*c]const u8,
    propertyMetaType: c_int,
    readSlot: [*c]const u8,
    writeSlot: [*c]const u8,
    notifySignal: [*c]const u8,
};
pub const PropertyDefinitions = extern struct {
    count: c_int,
    definitions: [*c]PropertyDefinition,
};
pub const DosQAbstractItemModelCallbacks = extern struct {
    rowCount: RowCountCallback,
    columnCount: ColumnCountCallback,
    data: DataCallback,
    setData: SetDataCallback,
    roleNames: RoleNamesCallback,
    flags: FlagsCallback,
    headerData: HeaderDataCallback,
    index: IndexCallback,
    parent: ParentCallback,
    hasChildren: HasChildrenCallback,
    canFetchMore: CanFetchMoreCallback,
    fetchMore: FetchMoreCallback,
};

pub const DosQEventLoopProcessEventFlag = enum(c_int) { DosQEventLoopProcessEventFlagProcessAllEvents = 0x00, DosQEventLoopProcessEventFlagExcludeUserInputEvents = 0x01, DosQEventLoopProcessEventFlagProcessExcludeSocketNotifiers = 0x02, DosQEventLoopProcessEventFlagProcessAllEventsWaitForMoreEvents = 0x03 };

pub const DosQtConnectionType = enum(c_int) {
    DosQtConnectionTypeAutoConnection = 0,
    DosQtConnectionTypeDirectConnection = 1,
    DosQtConnectionTypeQueuedConnection = 2,
    DosQtConnectionTypeBlockingConnection = 3,
    DosQtCOnnectionTypeUniqueConnection = 0x80,
};

pub const DosQVariant = c_void;
pub const DosQModelIndex = c_void;
pub const DosQAbstractItemModel = c_void;
pub const DosQAbstractListModel = c_void;
pub const DosQAbstractTableModel = c_void;
pub const DosQQmlApplicationEngine = c_void;
pub const DosQQuickView = c_void;
pub const DosQQmlContext = c_void;
pub const DosQHashIntQByteArray = c_void;
pub const DosQUrl = c_void;
pub const DosQMetaObject = c_void;
pub const DosQObject = c_void;
pub const DosQQuickImageProvider = c_void;
pub const DosPixmap = c_void;
pub const DosQPointer = c_void;
pub const RequestPixmapCallback = ?fn ([*c]const u8, [*c]c_int, [*c]c_int, c_int, c_int, ?*DosPixmap) callconv(.C) void;
pub const DObjectCallback = ?fn (?*c_void, ?*DosQVariant, c_int, [*c]?*DosQVariant) callconv(.C) void;
pub const RowCountCallback = ?fn (?*c_void, ?*const DosQModelIndex, [*c]c_int) callconv(.C) void;
pub const ColumnCountCallback = ?fn (?*c_void, ?*const DosQModelIndex, [*c]c_int) callconv(.C) void;
pub const DataCallback = ?fn (?*c_void, ?*const DosQModelIndex, c_int, ?*DosQVariant) callconv(.C) void;
pub const SetDataCallback = ?fn (?*c_void, ?*const DosQModelIndex, ?*const DosQVariant, c_int, [*c]bool) callconv(.C) void;
pub const RoleNamesCallback = ?fn (?*c_void, ?*DosQHashIntQByteArray) callconv(.C) void;
pub const FlagsCallback = ?fn (?*c_void, ?*const DosQModelIndex, [*c]c_int) callconv(.C) void;
pub const HeaderDataCallback = ?fn (?*c_void, c_int, c_int, c_int, ?*DosQVariant) callconv(.C) void;
pub const IndexCallback = ?fn (?*c_void, c_int, c_int, ?*const DosQModelIndex, ?*DosQModelIndex) callconv(.C) void;
pub const ParentCallback = ?fn (?*c_void, ?*const DosQModelIndex, ?*DosQModelIndex) callconv(.C) void;
pub const HasChildrenCallback = ?fn (?*c_void, ?*const DosQModelIndex, [*c]bool) callconv(.C) void;
pub const CanFetchMoreCallback = ?fn (?*c_void, ?*const DosQModelIndex, [*c]bool) callconv(.C) void;
pub const FetchMoreCallback = ?fn (?*c_void, ?*const DosQModelIndex) callconv(.C) void;
pub const CreateDObject = ?fn (c_int, ?*c_void, [*c]?*c_void, [*c]?*c_void) callconv(.C) void;
pub const DeleteDObject = ?fn (c_int, ?*c_void) callconv(.C) void;
pub const struct_DosQVariantArray = extern struct {
    size: c_int,
    data: [*c]?*DosQVariant,
};
pub const DosQVariantArray = struct_DosQVariantArray;
pub const struct_QmlRegisterType = extern struct {
    major: c_int,
    minor: c_int,
    uri: [*c]const u8,
    qml: [*c]const u8,
    staticMetaObject: ?*DosQMetaObject,
    createDObject: CreateDObject,
    deleteDObject: DeleteDObject,
};
pub const QmlRegisterType = struct_QmlRegisterType;
pub const struct_ParameterDefinition = extern struct {
    name: [*c]const u8,
    metaType: c_int,
};
pub const ParameterDefinition = struct_ParameterDefinition;
pub const struct_SignalDefinition = extern struct {
    name: [*c]const u8,
    parametersCount: c_int,
    parameters: [*c]ParameterDefinition,
};
pub const SignalDefinition = struct_SignalDefinition;
pub const struct_SignalDefinitions = extern struct {
    count: c_int,
    definitions: [*c]SignalDefinition,
};
pub const SignalDefinitions = struct_SignalDefinitions;
pub const struct_SlotDefinition = extern struct {
    name: [*c]const u8,
    returnMetaType: c_int,
    parametersCount: c_int,
    parameters: [*c]ParameterDefinition,
};
pub const SlotDefinition = struct_SlotDefinition;
pub const struct_SlotDefinitions = extern struct {
    count: c_int,
    definitions: [*c]SlotDefinition,
};
pub const SlotDefinitions = struct_SlotDefinitions;
pub const struct_PropertyDefinition = extern struct {
    name: [*c]const u8,
    propertyMetaType: c_int,
    readSlot: [*c]const u8,
    writeSlot: [*c]const u8,
    notifySignal: [*c]const u8,
};
pub const PropertyDefinition = struct_PropertyDefinition;
pub const struct_PropertyDefinitions = extern struct {
    count: c_int,
    definitions: [*c]PropertyDefinition,
};
pub const PropertyDefinitions = struct_PropertyDefinitions;
pub const struct_DosQAbstractItemModelCallbacks = extern struct {
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
pub const DosQAbstractItemModelCallbacks = struct_DosQAbstractItemModelCallbacks;
pub const DosQEventLoopProcessEventFlagProcessAllEvents = @enumToInt(enum_DosQEventLoopProcessEventFlag.ProcessAllEvents);
pub const DosQEventLoopProcessEventFlagExcludeUserInputEvents = @enumToInt(enum_DosQEventLoopProcessEventFlag.ExcludeUserInputEvents);
pub const DosQEventLoopProcessEventFlagProcessExcludeSocketNotifiers = @enumToInt(enum_DosQEventLoopProcessEventFlag.ProcessExcludeSocketNotifiers);
pub const DosQEventLoopProcessEventFlagProcessAllEventsWaitForMoreEvents = @enumToInt(enum_DosQEventLoopProcessEventFlag.ProcessAllEventsWaitForMoreEvents);
pub const enum_DosQEventLoopProcessEventFlag = extern enum(c_int) {
    ProcessAllEvents = 0,
    ExcludeUserInputEvents = 1,
    ProcessExcludeSocketNotifiers = 2,
    ProcessAllEventsWaitForMoreEvents = 3,
    _,
};
pub const DosQtConnectionTypeAutoConnection = @enumToInt(enum_DosQtConnectionType.AutoConnection);
pub const DosQtConnectionTypeDirectConnection = @enumToInt(enum_DosQtConnectionType.DirectConnection);
pub const DosQtConnectionTypeQueuedConnection = @enumToInt(enum_DosQtConnectionType.QueuedConnection);
pub const DosQtConnectionTypeBlockingConnection = @enumToInt(enum_DosQtConnectionType.BlockingConnection);
pub const DosQtCOnnectionTypeUniqueConnection = @enumToInt(enum_DosQtConnectionType.DosQtCOnnectionTypeUniqueConnection);
pub const enum_DosQtConnectionType = extern enum(c_int) {
    AutoConnection = 0,
    DirectConnection = 1,
    QueuedConnection = 2,
    BlockingConnection = 3,
    DosQtCOnnectionTypeUniqueConnection = 128,
    _,
};

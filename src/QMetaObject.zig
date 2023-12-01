const std = @import("std");
const dos = @import("DOtherSide.zig");
const QMetaType = @import("QMetaType.zig").QMetaType;

pub const ParameterDefinition = struct {
    name: [*c]const u8,
    type_: QMetaType,
};

pub const SignalDefinition = struct {
    name: [*c]const u8,
    parameters: []const ParameterDefinition,
};

pub const SlotDefinition = struct {
    name: [*c]const u8,
    returnType: QMetaType,
    parameters: []const ParameterDefinition,
};

pub const PropertyDefinition = struct {
    name: [*c]const u8,
    type_: QMetaType,
    readSlot: [*c]const u8,
    writeSlot: [*c]const u8,
    notifySignal: [*c]const u8,
};

pub const QMetaObject = struct {
    vptr: ?*dos.DosQMetaObject,

    pub fn create(parent: ?*dos.DosQObject, comptime T: type) anyerror!QMetaObject {
        const signals_ = try allocSignalDefinitions(T);
        defer freeSignalDefinitions(signals_);

        const slots_ = try allocSlotDefinitions(T);
        defer freeSlotDefinitions(slots_);

        const properties_ = try allocPropertyDefinitions(T);
        defer freePropertyDefinitions(properties_);
        return QMetaObject{ .vptr = dos.dos_qmetaobject_create(parent, &@typeName(T)[0], &signals_, &slots_, &properties_) };
    }

    pub fn delete(Self: QMetaObject) void {
        dos.dos_qmetaobject_delete(Self.vptr);
    }

    //TODO: invoke method

    fn allocSignalDefinitions(comptime T: type) anyerror!dos.SignalDefinitions {
        comptime var signals: []const SignalDefinition = &[_]SignalDefinition{};
        inline for (@typeInfo(T).Struct.decls) |declaration| {
            switch (declaration.data) {
                .Var => |Var| {
                    switch (@typeInfo(Var)) {
                        .Fn => |Fn| {
                            comptime var parameters: []const ParameterDefinition = &[_]ParameterDefinition{};

                            inline for (Fn.args, 0..) |arg, i| {
                                if (i == 0)
                                    continue;
                                parameters = parameters ++ &[_]ParameterDefinition{.{
                                    .name = "arg", // TODO: somehow get the argument names
                                    .type_ = QMetaType.toQMetaType(arg.arg_type),
                                }};
                            }

                            signals = signals ++ &[_]SignalDefinition{.{
                                .name = &declaration.name[0],
                                .parameters = parameters,
                            }};
                        },
                        else => continue,
                    }
                },
                else => continue,
            }
        }

        const allocator = std.heap.page_allocator;
        const list = try allocator.alloc(dos.SignalDefinition, signals.len);

        for (signals, 0..) |signal, i| {
            var parameterList = try allocator.alloc(dos.ParameterDefinition, signal.parameters.len);
            for (signal.parameters, 0..) |parameter, pi| {
                parameterList[pi] = dos.ParameterDefinition{
                    .name = parameter.name,
                    .metaType = @intFromEnum(parameter.type_),
                };
            }
            list[i] = dos.SignalDefinition{
                .name = signal.name,
                .parametersCount = @as(c_int, @intCast(signal.parameters.len)),
                .parameters = if (signal.parameters.len > 0) &parameterList[0] else null,
            };
        }

        if (signals.len > 0) {
            return dos.SignalDefinitions{
                .count = @as(c_int, @intCast(signals.len)),
                .definitions = &list[0],
            };
        } else {
            return dos.SignalDefinitions{
                .count = 0,
                .definitions = null,
            };
        }
    }

    fn allocSlotDefinitions(comptime T: type) anyerror!dos.SlotDefinitions {
        comptime var slots: []const SlotDefinition = &[_]SlotDefinition{};

        inline for (@typeInfo(T).Struct.decls) |declaration| {
            switch (declaration.data) {
                .Fn => |Fn| {
                    comptime var parameters: []const ParameterDefinition = &[_]ParameterDefinition{};

                    inline for (@typeInfo(Fn.fn_type).Fn.args, 0..) |arg, i| {
                        if (i == 0)
                            continue;
                        parameters = parameters ++ &[_]ParameterDefinition{.{
                            .name = "arg", // TODO: somehow get the argument names
                            .type_ = QMetaType.toQMetaType(arg.arg_type),
                        }};
                    }

                    slots = slots ++ &[_]SlotDefinition{.{
                        .name = &declaration.name[0],
                        .returnType = QMetaType.toQMetaType(Fn.return_type),
                        .parameters = parameters,
                    }};
                },
                else => continue,
            }
        }

        const allocator = std.heap.page_allocator;
        const list = try allocator.alloc(dos.SlotDefinition, slots.len);

        for (slots, 0..) |slot, i| {
            var parameterList = try allocator.alloc(dos.ParameterDefinition, slot.parameters.len);
            for (slot.parameters, 0..) |parameter, pi| {
                parameterList[pi] = dos.ParameterDefinition{
                    .name = parameter.name,
                    .metaType = @intFromEnum(parameter.type_),
                };
            }
            list[i] = dos.SlotDefinition{
                .name = slot.name,
                .parametersCount = @as(c_int, @intCast(parameterList.len)),
                .returnMetaType = @intFromEnum(slot.returnType),
                .parameters = if (slot.parameters.len > 0) &parameterList[0] else null,
            };
        }
        if (slots.len > 0) {
            return dos.SlotDefinitions{
                .count = @as(c_int, @intCast(slots.len)),
                .definitions = &list[0],
            };
        } else {
            return dos.SlotDefinitions{
                .count = 0,
                .definitions = null,
            };
        }
    }

    fn allocPropertyDefinitions(comptime T: type) anyerror!dos.PropertyDefinitions {
        comptime var properties: []const PropertyDefinition = &[_]PropertyDefinition{};

        inline for (@typeInfo(T).Struct.fields) |field| {
            comptime if (field.field_type == ?*anyopaque)
                continue;
            const name = &[_]u8{toUpper(field.name[0])} ++ field.name[1..field.name.len];

            comptime if (!@hasDecl(T, "get" ++ name))
                @compileError("Field \"" ++ field.name ++ "\" doesnt have getter: get" ++ name);

            properties = properties ++ &[_]PropertyDefinition{.{
                .name = &field.name[0],
                .type_ = QMetaType.toQMetaType(field.field_type),
                .readSlot = "get" ++ name,
                .writeSlot = if (@hasDecl(T, "set" ++ name)) "set" ++ name else null,
                .notifySignal = if (hasSignal(T, field.name ++ "Changed")) field.name ++ "Changed" else null,
            }};
        }

        const allocator = std.heap.page_allocator;
        const list = try allocator.alloc(dos.PropertyDefinition, properties.len);

        for (properties, 0..) |property, i| {
            list[i] = dos.PropertyDefinition{
                .name = property.name,
                .propertyMetaType = @intFromEnum(property.type_),
                .readSlot = property.readSlot,
                .writeSlot = property.writeSlot,
                .notifySignal = property.notifySignal,
            };
        }

        const result = dos.PropertyDefinitions{
            .count = @as(c_int, @intCast(properties.len)),
            .definitions = &list[0],
        };

        return result;
    }

    fn freeSignalDefinitions(signals: dos.SignalDefinitions) void {
        if (signals.count > 0) {
            for (signals.definitions[0..@as(usize, @intCast(signals.count))]) |signal| {
                std.heap.page_allocator.free(signal.parameters[0..@as(usize, @intCast(signal.parametersCount))]);
            }
            std.heap.page_allocator.free(signals.definitions[0..@as(usize, @intCast(signals.count))]);
        }
    }

    fn freeSlotDefinitions(slots: dos.SlotDefinitions) void {
        if (slots.count > 0) {
            for (slots.definitions[0..@as(usize, @intCast(slots.count))]) |slot| {
                if (slot.parametersCount > 0) {
                    std.heap.page_allocator.free(slot.parameters[0..@as(usize, @intCast(slot.parametersCount))]);
                }
            }
            std.heap.page_allocator.free(slots.definitions[0..@as(usize, @intCast(slots.count))]);
        }
    }

    fn freePropertyDefinitions(properties: dos.PropertyDefinitions) void {
        if (properties.count > 0) {
            std.heap.page_allocator.free(properties.definitions[0..@as(usize, @intCast(properties.count))]);
        }
    }
};

fn toUpper(c: u8) u8 {
    if (c <= 'z' and c >= 'a')
        return c - ' ';
    return c;
}

fn hasSignal(comptime T: type, comptime name: []const u8) bool {
    inline for (@typeInfo(T).Struct.decls) |declaration| {
        switch (declaration.data) {
            .Var => |Var| {
                switch (@typeInfo(Var)) {
                    .Fn => |Fn| {
                        _ = Fn;

                        if (std.mem.eql(u8, name, declaration.name))
                            return true;
                    },
                    else => continue,
                }
            },
            else => continue,
        }
    }
    return false;
}

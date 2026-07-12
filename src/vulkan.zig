// vulkan_core.h
const ApiVersion = packed struct(u32) {
    patch: u12,
    minor: u10,
    major: u7,
    variant: u3,

    fn make(variant: u3, major: u7, minor: u10, patch: u12) ApiVersion { // 62
        return .{
            .variant = variant,
            .major = major,
            .minor = minor,
            .patch = patch,
        };
    }

    pub const @"1_0" = make(0, 1, 0, 0); // 92
};

const Version = packed struct(u32) {
    patch: u12,
    minor: u10,
    major: u10,

    pub fn make(major: u10, minor: u10, patch: u12) Version { // 75
        return .{
            .major = major,
            .minor = minor,
            .patch = patch,
        };
    }
};

const Flags = packed struct(u32) { // 97
    _pad0: u32 = 0,
};

const InstanceImpl = opaque { // 101
    extern fn vkDestroyInstance( // 4570
        instance: Instance,
        allocator: ?*const AllocationCallbacks,
    ) void;
    pub const deinit = vkDestroyInstance;

    extern fn vkCreateInstance( // 5100
        create_info: *const InstanceCreateInfo,
        allocator: ?*const AllocationCallbacks,
        instance: *Instance,
    ) Result;
    pub fn init(
        create_info: *const InstanceCreateInfo,
        allocator: ?*const AllocationCallbacks,
    ) Instance {
        var self: Instance = undefined;
        if (vkCreateInstance(create_info, allocator, &self) != .success) unreachable; // todo
        return self;
    }
};
pub const Instance = *InstanceImpl;

const max_extension_name_size = 256; // 134

const Result = enum(c_int) { // 140
    success = 0, // 141
};

const StructureType = enum(c_uint) { // 206
    application_info = 0,
    instance_create_info = 1,
};

const SystemAllocationScope = enum(c_uint) {}; // 1793

const InternalAllocationType = enum(c_uint) {}; // 1802

const InstanceCreateFlags = Flags; // 2802

pub const AllocationFunction = ?*const fn ( // 3378
    user_data: ?*anyopaque,
    size: usize,
    alignment: usize,
    allocation_scope: SystemAllocationScope,
) callconv(.c) ?*anyopaque;

pub const FreeFunction = ?*const fn ( // 3384
    user_data: ?*anyopaque,
    memory: ?*anyopaque,
) callconv(.c) void;

pub const InternalAllocationNotification = ?*const fn ( // 3388
    user_data: ?*anyopaque,
    size: usize,
    allocation_type: InternalAllocationType,
    allocation_scope: SystemAllocationScope,
) callconv(.c) void;

pub const InternalFreeNotification = ?*const fn ( // 3394
    user_data: ?*anyopaque,
    size: usize,
    allocation_type: InternalAllocationType,
    allocation_scope: SystemAllocationScope,
) callconv(.c) void;

pub const ReallocationFunction = ?*const fn ( // 3400
    userData: ?*anyopaque,
    original: ?*anyopaque,
    size: usize,
    alignment: usize,
    allocation_scope: SystemAllocationScope,
) callconv(.c) ?*anyopaque;

pub const AllocationCallbacks = extern struct { // 3408
    user_data: ?*anyopaque = null,
    allocation: AllocationFunction = null,
    reallocation: ReallocationFunction = null,
    free: FreeFunction = null,
    internal_allocation: InternalAllocationNotification = null,
    internal_free: InternalFreeNotification = null,
};

pub const ApplicationInfo = extern struct { // 3417
    type: StructureType = .application_info,
    next: ?*const anyopaque = null,
    application_name: [*:0]const u8,
    application_version: Version,
    engine_name: [*:0]const u8,
    engine_version: Version,
    api_version: ApiVersion,
};

pub const InstanceCreateInfo = extern struct { // 3441
    type: StructureType = .instance_create_info,
    next: ?*const anyopaque = null,
    flags: InstanceCreateFlags = .{},
    application_info: *const ApplicationInfo,
    enabled_layer_count: u32 = 0,
    enabled_layer_names: ?[*]const [*:0]const u8 = null,
    enabled_extension_count: u32 = 0,
    enabled_extension_names: ?[*]const [*:0]const u8 = null,
};

const ExtensionProperties = extern struct { // 3687
    extension_name: [max_extension_name_size]u8,
    spec_version: u32,
};

extern fn vkEnumerateInstanceExtensionProperties( // 4628
    layer_name: [*c]const u8,
    property_count: [*c]u32,
    properties: [*c]ExtensionProperties,
) Result;
pub const enumerateInstanceExtensionProperties = vkEnumerateInstanceExtensionProperties;

const c = @import("glfw.zig").c;
const std = @import("std");
/// Returns up to requested number of global extension properties
pub const enumerateInstanceExtensionProperties = c.vkEnumerateInstanceExtensionProperties;
/// Construct an API version number
pub const makeVersion = c.VK_MAKE_VERSION;
/// Create a new Vulkan instance
pub extern fn vkCreateInstance(pCreateInfo: [*c]const InstanceCreateInfo, pAllocator: [*c]const c.VkAllocationCallbacks, pInstance: [*c]c.VkInstance) c.VkResult;
pub const createInstance = vkCreateInstance;
/// Destroy an instance of Vulkan
pub const destroyInstance = c.vkDestroyInstance;
/// Returns up to requested number of global layer properties
pub const enumerateInstanceLayerProperties = c.vkEnumerateInstanceLayerProperties;
/// Opaque handle to an instance object
pub const Instance = c.VkInstance;
/// Bitmask specifying which severities of events cause a debug messenger callback
pub const DebugUtilsMessageSeverityFlagBitsEXT = c.VkDebugUtilsMessageSeverityFlagBitsEXT;
pub const debug_utils_message_severity_verbose_bit_ext = c.VK_DEBUG_UTILS_MESSAGE_SEVERITY_VERBOSE_BIT_EXT;
pub const debug_utils_message_severity_warning_bit_ext = c.VK_DEBUG_UTILS_MESSAGE_SEVERITY_WARNING_BIT_EXT;
pub const debug_utils_message_severity_error_bit_ext = c.VK_DEBUG_UTILS_MESSAGE_SEVERITY_ERROR_BIT_EXT;
/// Bitmask of VkDebugUtilsMessageTypeFlagBitsEXT
pub const DebugUtilsMessageTypeFlagsEXT = c.VkDebugUtilsMessageTypeFlagsEXT;
pub const debug_utils_message_type_general_bit_ext = c.VK_DEBUG_UTILS_MESSAGE_TYPE_GENERAL_BIT_EXT;
pub const debug_utils_message_type_validation_bit_ext = c.VK_DEBUG_UTILS_MESSAGE_TYPE_VALIDATION_BIT_EXT;
pub const debug_utils_message_type_performance_bit_ext = c.VK_DEBUG_UTILS_MESSAGE_TYPE_PERFORMANCE_BIT_EXT;
/// Vulkan boolean type
pub const Bool32 = c.VkBool32;
/// Structure specifying layer properties
pub const LayerProperties = c.VkLayerProperties;
/// Return API version number for Vulkan 1.0
pub const api_version_1_0 = c.VK_API_VERSION_1_0;
/// Command successfully completed
pub const success = c.VK_SUCCESS;
/// instance extension
pub const ext_debug_utils_extension_name = c.VK_EXT_DEBUG_UTILS_EXTENSION_NAME;
/// Structure specifying parameters of a newly created debug messenger
pub const DebugUtilsMessengerCreateInfoEXT = c.VkDebugUtilsMessengerCreateInfoEXT;
/// Structure specifying parameters returned to the callback
pub const DebugUtilsMessengerCallbackDataEXT = c.VkDebugUtilsMessengerCallbackDataEXT;
/// Vulkan structure types (pname:sType)
pub const structure_type_application_info = c.VK_STRUCTURE_TYPE_APPLICATION_INFO;
pub const structure_type_debug_utils_messenger_create_info_ext = c.VK_STRUCTURE_TYPE_DEBUG_UTILS_MESSENGER_CREATE_INFO_EXT;
pub const structure_type_instance_create_info = c.VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO;
/// Create a debug messenger object
pub fn createDebugUtilsMessengerEXT(instance: Instance, pCreateInfo: *const DebugUtilsMessengerCreateInfoEXT, pAllocator: ?*const c.VkAllocationCallbacks, pDebugMessenger: *c.VkDebugUtilsMessengerEXT) c.VkResult {
    const func: c.PFN_vkCreateDebugUtilsMessengerEXT = @ptrCast(c.vkGetInstanceProcAddr(instance, "vkCreateDebugUtilsMessengerEXT"));
    if (func) |f| {
        return f(instance, pCreateInfo, pAllocator, pDebugMessenger);
    } else {
        return c.VK_ERROR_EXTENSION_NOT_PRESENT;
    }
}
/// Destroy a debug messenger object
pub fn destroyDebugUtilsMessengerEXT(instance: Instance, debugMessenger: DebugUtilsMessengerEXT, pAllocator: ?*const c.VkAllocationCallbacks) void {
    const func: c.PFN_vkDestroyDebugUtilsMessengerEXT = @ptrCast(c.vkGetInstanceProcAddr(instance, "vkDestroyDebugUtilsMessengerEXT"));
    if (func) |f| {
        f(instance, debugMessenger, pAllocator);
    }
}
/// Opaque handle to a debug messenger object
pub const DebugUtilsMessengerEXT = c.VkDebugUtilsMessengerEXT;

/// Bitmask specifying behavior of the instance
const InstanceCreateFlagBits = packed struct {
    numerate_portability_bit_khr: bool = false,
    reserved: u31 = 0,
};

/// VkInstanceCreateInfo - Structure specifying parameters of a newly created instance
pub const InstanceCreateInfo = extern struct {
    sType: c.VkStructureType = c.VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO,
    pNext: ?*const anyopaque,
    flags: c.VkInstanceCreateFlags = @import("std").mem.zeroes(c.VkInstanceCreateFlags),
    pApplicationInfo: [*c]const ApplicationInfo,
    enabledLayerCount: u32,
    ppEnabledLayerNames: [*c]const [*c]const u8,
    enabledExtensionCount: u32,
    ppEnabledExtensionNames: [*c]const [*c]const u8,

    pub fn init(allocator: std.mem.Allocator, options: struct {
        next: ?*const anyopaque = null,
        flags: InstanceCreateFlagBits = .{},
        application_info: ?*const ApplicationInfo = null,
        enabled_layers: ?[]const []const u8 = null,
        enabled_extensions: ?[]const []const u8 = null,
    }) !InstanceCreateInfo {
        var enabled_layers: std.ArrayList([*c]const u8) = .init(allocator);
        // defer enabled_layers.deinit();
        if (options.enabled_layers) |options_enabled_layers| {
            for (options_enabled_layers) |enabled_layer| {
                try enabled_layers.append(try allocator.dupeZ(u8, enabled_layer));
            }
        }
        var enabled_extensions: std.ArrayList([*c]const u8) = .init(allocator);
        // defer enabled_extensions.deinit();
        if (options.enabled_extensions) |options_enabled_extensions| {
            for (options_enabled_extensions) |enabled_extension| {
                try enabled_extensions.append(try allocator.dupeZ(u8, enabled_extension));
            }
        }
        // std.debug.print("{any} {any}\n", .{ enabled_layers.items[0], enabled_layers.items[0][27]});
        return .{
            .pNext = options.next,
            .flags = @bitCast(options.flags),
            .pApplicationInfo = if (options.application_info) |application_info| application_info else null,
            .enabledLayerCount = @intCast(enabled_layers.items.len),
            .ppEnabledLayerNames = @ptrCast(try enabled_layers.toOwnedSlice()),
            .enabledExtensionCount = @intCast(enabled_extensions.items.len),
            .ppEnabledExtensionNames = @ptrCast(try enabled_extensions.toOwnedSlice()),
        };
    }
};

pub const VersionBits = packed struct {
    patch: u12 = 0,
    minor: u10 = 0,
    major: u10 = 0,
};

pub const ApiVersionBits = packed struct {
    patch: u12 = 0,
    minor: u10 = 0,
    major: u7 = 0,
    variant: u3 = 0,
};

pub const ApiVersion = enum(u32) {
    @"1.0" = @bitCast(ApiVersionBits{ .major = 1, .minor = 0 }),
    @"1.1" = @bitCast(ApiVersionBits{ .major = 1, .minor = 1 }),
    @"1.2" = @bitCast(ApiVersionBits{ .major = 1, .minor = 2 }),
    @"1.3" = @bitCast(ApiVersionBits{ .major = 1, .minor = 3 }),
    @"1.4" = @bitCast(ApiVersionBits{ .major = 1, .minor = 4 }),
};

/// VkApplicationInfo - Structure specifying application information
pub const ApplicationInfo = extern struct {
    sType: c.VkStructureType = c.VK_STRUCTURE_TYPE_APPLICATION_INFO,
    pNext: ?*const anyopaque,
    pApplicationName: [*c]const u8,
    applicationVersion: u32,
    pEngineName: [*c]const u8,
    engineVersion: u32,
    apiVersion: u32,

    pub fn init(options: struct {
        next: ?*const anyopaque = null,
        name: ?[]const u8 = null,
        version: VersionBits = .{},
        engine_name: ?[]const u8 = null,
        engine_version: VersionBits = .{},
        api_version: ApiVersion = .@"1.0",
    }) ApplicationInfo {
        return .{
            .pNext = options.next,
            .pApplicationName = if (options.name) |name| name.ptr else std.mem.zeroes([*c]const u8),
            .applicationVersion = @bitCast(options.version),
            .pEngineName = if (options.engine_name) |name| name.ptr else std.mem.zeroes([*c]const u8),
            .engineVersion = @bitCast(options.engine_version),
            .apiVersion = @intFromEnum(options.api_version),
        };
    }
};

const c = @import("glfw.zig").c;
/// Returns up to requested number of global extension properties
pub const enumerateInstanceExtensionProperties = c.vkEnumerateInstanceExtensionProperties;
/// Construct an API version number
pub const makeVersion = c.VK_MAKE_VERSION;
/// Create a new Vulkan instance
pub const createInstance = c.vkCreateInstance;
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
/// Structure specifying application information
pub const ApplicationInfo = c.VkApplicationInfo;
/// Structure specifying parameters of a newly created instance
pub const InstanceCreateInfo = c.VkInstanceCreateInfo;
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

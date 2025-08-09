const c = @import("glfw.zig").c;
/// Returns up to requested number of global extension properties
pub const enumerateInstanceExtensionProperties = c.vkEnumerateInstanceExtensionProperties;
/// Construct an API version number
pub const makeVersion = c.VK_MAKE_VERSION;
/// Create a new Vulkan instance
pub const createInstance = c.vkCreateInstance;
/// Destroy an instance of Vulkan
pub const destroyInstance = c.vkDestroyInstance;
/// VkInstance - Opaque handle to an instance object
pub const Instance = c.VkInstance;
/// Return API version number for Vulkan 1.0
pub const api_version_1_0 = c.VK_API_VERSION_1_0;
/// Structure specifying application information
pub const ApplicationInfo = c.VkApplicationInfo;
/// Structure specifying parameters of a newly created instance
pub const InstanceCreateInfo = c.VkInstanceCreateInfo;
/// Command successfully completed
pub const success = c.VK_SUCCESS;
/// Vulkan structure types (pname:sType)
pub const structure_type_application_info = c.VK_STRUCTURE_TYPE_APPLICATION_INFO;
pub const structure_type_instance_create_info = c.VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO;


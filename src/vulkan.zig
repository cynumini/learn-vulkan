const Result = c_int;

pub const ExtensionProperties = extern struct {
    extensionName: [256]u8,
    specVersion: u32 = 0,
};

extern fn vkEnumerateInstanceExtensionProperties(pLayerName: [*c]const u8, pPropertyCount: [*c]u32, pProperties: [*c]ExtensionProperties) Result;
pub const enumerateInstanceExtensionProperties = vkEnumerateInstanceExtensionProperties;

const std = @import("std");
const c = @import("c");

const width = 800;
const height = 600;

const Application = struct {
    const Self = @This();

    window: ?*c.GLFWwindow = null,
    instance: ?c.VkInstance = null,

    pub fn run(self: *Self) !void {
        self.initWindow();
        Self.initVulkan();
        self.mainLoop();
        self.cleanup();
    }

    fn initWindow(self: *Self) void {
        _ = c.glfwInit();

        c.glfwWindowHint(c.GLFW_CLIENT_API, c.GLFW_NO_API);
        c.glfwWindowHint(c.GLFW_RESIZABLE, c.GLFW_FALSE);

        self.window = c.glfwCreateWindow(width, height, "Vulkan", null, null);
    }

    fn initVulkan() void {
        // createInstance();
    }

    fn mainLoop(self: *const Self) void {
        while (c.glfwWindowShouldClose(self.window) != 0) {
            c.glfwPollEvents();
        }
    }
    
    fn cleanup(self: *Self) void {
        // c.vkDestroyInstance(self.instance.?, null);

        c.glfwDestroyWindow(self.window.?);

        c.glfwTerminate();
    }

    // void createInstance() {
    //     VkApplicationInfo appInfo{};
    //     appInfo.sType = VK_STRUCTURE_TYPE_APPLICATION_INFO;
    //     appInfo.pApplicationName = "Hello Triangle";
    //     appInfo.applicationVersion = VK_MAKE_VERSION(1, 0, 0);
    //     appInfo.pEngineName = "No Engine";
    //     appInfo.engineVersion = VK_MAKE_VERSION(1, 0, 0);
    //     appInfo.apiVersion = VK_API_VERSION_1_0;
    //
    //     VkInstanceCreateInfo createInfo{};
    //     createInfo.sType = VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO;
    //     createInfo.pApplicationInfo = &appInfo;
    //
    //     uint32_t glfwExtensionCount = 0;
    //     const char** glfwExtensions;
    //     glfwExtensions = glfwGetRequiredInstanceExtensions(&glfwExtensionCount);
    //
    //     createInfo.enabledExtensionCount = glfwExtensionCount;
    //     createInfo.ppEnabledExtensionNames = glfwExtensions;
    //
    //     createInfo.enabledLayerCount = 0;
    //
    //     if (vkCreateInstance(&createInfo, nullptr, &instance) != VK_SUCCESS) {
    //         throw std::runtime_error("failed to create instance!");
    //     }
    // }

};

pub fn main() !void {
    var app = Application {};
    try app.run();
}

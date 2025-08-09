pub const c = @cImport({
    @cDefine("GLFW_INCLUDE_VULKAN", {});
    @cInclude("GLFW/glfw3.h");
});

pub const init = c.glfwInit;
pub const terminate = c.glfwTerminate;
pub const windowHint = c.glfwWindowHint;
pub const createWindow = c.glfwCreateWindow;
pub const destroyWindow = c.glfwDestroyWindow;
pub const pollEvents= c.glfwPollEvents;

pub fn windowShouldClose(window: ?*c.GLFWwindow) bool {
    return c.glfwWindowShouldClose(window) == 1;
}

pub const client_api = c.GLFW_CLIENT_API;
pub const no_api = c.GLFW_NO_API;

#include <cstdio>
#include <fstream>
#include <vector>

#define GLFW_INCLUDE_VULKAN

#include <GLFW/glfw3.h>

#define GLM_FORCE_RADIANS
#define GLM_FORCE_DEPTH_ZERO_TO_ONE
#include <glm/mat4x4.hpp>
#include <glm/vec4.hpp>

#include "sakana/sakana.hpp"

static constexpr int WIDTH = 800;
static constexpr int HEIGHT = 600;

std::vector<char> readFile(std::string file_path) {
    std::ifstream file{file_path, std::ios::ate | std::ios::binary};
    defer(file.close());

    if (!file.is_open()) {
        printf("failed to open: %s\n", file_path.c_str());
        abort();
    }

    auto file_size = (size_t)file.tellg();
    std::vector<char> buffer(file_size);

    file.seekg(0);
    file.read(buffer.data(), file_size);

    return buffer;
}

void createGraphicsPipelines(std::string vert_filepath,
                             std::string frag_filepath) {
    auto vert_code = readFile(vert_filepath);
    auto frag_code = readFile(frag_filepath);

    printf("Vertex shader code size: %lu\n", vert_code.size());
    printf("Fragment shader code size: %lu\n", frag_code.size());
}

int main() {
    createGraphicsPipelines("./shaders/simple_shader.vert.spv",
                            "./shaders/simple_shader.frag.spv");

    glfwInit();
    defer(glfwTerminate());

    glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
    glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE);

    auto window =
        glfwCreateWindow(WIDTH, HEIGHT, "Hello Vulkan!", nullptr, nullptr);
    defer(glfwDestroyWindow(window));

    while (!glfwWindowShouldClose(window)) {
        glfwPollEvents();
    }

    return 0;
}

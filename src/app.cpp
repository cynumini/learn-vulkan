#pragma once

#include <assert.h>
#include <stdio.h>

#define GLFW_INCLUDE_VULKAN
#include <GLFW/glfw3.h>

#include <vulkan/vulkan.h>

struct App {
  GLFWwindow *window;
  VkInstance instance;

  static const int width = 800;
  static const int height = 600;
};

GLFWwindow *appInitWindow() {
  printf("appInit\n");

  glfwInit();

  glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
  glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE);

  return glfwCreateWindow(App::width, App::height, "Vulkan", NULL, NULL);
}

VkInstance appCreateInstance() {
  VkApplicationInfo app_info{};
  app_info.sType = VK_STRUCTURE_TYPE_APPLICATION_INFO;
  app_info.pApplicationName = "Hello Triangle";
  app_info.applicationVersion = VK_MAKE_VERSION(1, 0, 0);
  app_info.pEngineName = "No Engine";
  app_info.engineVersion = VK_MAKE_VERSION(1, 0, 0);
  app_info.apiVersion = VK_API_VERSION_1_0;

  VkInstanceCreateInfo create_info{};
  create_info.sType = VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO;
  create_info.pApplicationInfo = &app_info;

  uint32_t glfw_extension_count = 0;
  const char **glfw_extensions;
  glfw_extensions = glfwGetRequiredInstanceExtensions(&glfw_extension_count);

  create_info.enabledExtensionCount = glfw_extension_count;
  create_info.ppEnabledExtensionNames = glfw_extensions;

  create_info.enabledLayerCount = 0;

  VkInstance instance;
  assert(vkCreateInstance(&create_info, NULL, &instance) == VK_SUCCESS);
  return instance;
}

VkInstance appInitVulkan() { return appCreateInstance(); };

App appInit() {
  auto window = appInitWindow();
  auto instance = appInitVulkan();

  return {.window = window, .instance = instance};
}

void appDeinit(App *app) {
  printf("appDeinit\n");

  vkDestroyInstance(app->instance, NULL);

  glfwDestroyWindow(app->window);

  glfwTerminate();
}

void appRun(App *app) {
  printf("appRun\n");

  while (!glfwWindowShouldClose(app->window)) {
    glfwPollEvents();
  }
}

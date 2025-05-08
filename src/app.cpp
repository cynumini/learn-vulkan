#pragma once

#include <stdio.h>

#define GLFW_INCLUDE_VULKAN
#include <GLFW/glfw3.h>

struct App {
  GLFWwindow *window;

  static const int width = 800;
  static const int height = 600;
};

App appInit() {
  printf("appInit\n");

  glfwInit();

  glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
  glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE);

  auto window = glfwCreateWindow(App::width, App::height, "Vulkan", NULL, NULL);

  return {.window = window};
}

void appDeinit(App *app) {
  printf("appDeinit\n");

  glfwDestroyWindow(app->window);

  glfwTerminate();
}

void appRun(App *app) {
  printf("appRun\n");

  while (!glfwWindowShouldClose(app->window)) {
    glfwPollEvents();
  }
}

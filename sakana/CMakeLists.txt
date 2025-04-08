cmake_minimum_required(VERSION 3.10)

project(sakana)

file(GLOB sakana-src "./src/sakana/*.cpp")

add_library(sakana SHARED ${sakana-src})

target_link_libraries(sakana glfw vulkan)

target_include_directories(sakana PUBLIC ./src)

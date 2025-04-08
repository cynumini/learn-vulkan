cmake_minimum_required(VERSION 3.10)

project(learn-vulkan)

set(CMAKE_EXPORT_COMPILE_COMMANDS 1)

add_subdirectory(sakana)

file(GLOB learn-vulkan-src "./src/*.cpp")

add_executable(learn-vulkan ${learn-vulkan-src})

target_link_libraries(learn-vulkan sakana)

#!/usr/bin/env sh

glslc ./shaders/simple_shader.vert -o ./shaders/simple_shader.vert.spv
glslc ./shaders/simple_shader.frag -o ./shaders/simple_shader.frag.spv

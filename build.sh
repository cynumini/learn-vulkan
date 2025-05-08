#!/usr/bin/env sh

set -e

mkdir -p out

clang-format -i src/*

g++ ./src/main.cpp -lglfw -lvulkan -o out/learn-vulkan

./out/learn-vulkan

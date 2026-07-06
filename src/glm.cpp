#define GLM_FORCE_RADIANS
#define GLM_FORCE_DEPTH_ZERO_TO_ONE
#include <glm/mat4x4.hpp>
#include <glm/vec4.hpp>

extern "C" void lv_glm_test() {
    glm::mat4 matrix;
    glm::vec4 vec;
    auto test = matrix * vec;
}

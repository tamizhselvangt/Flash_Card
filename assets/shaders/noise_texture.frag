#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform float uTime;

out vec4 fragColor;

// Simple 2D noise function
float noise(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

void main() {
    vec2 fragCoord = FlutterFragCoord().xy;
    vec2 uv = fragCoord / uSize;

    // Create noise pattern
    float n = noise(uv * 10.0 + uTime * 0.1);

    // Adjust color and opacity for subtle effect
    vec3 color = vec3(0.95, 0.95, 0.95); // Light gray
    fragColor = vec4(color, 0.1 + n * 0.05); // Subtle opacity variation
}


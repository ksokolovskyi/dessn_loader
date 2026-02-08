#version 320 es

precision highp float;

#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform sampler2D uTexture;

out vec4 fragColor;

const float kIntensity = 0.25;
const float kThreshold = 0.3; 

vec4 extractBrightColor(vec4 color) {
  float luma = dot(color.rgb, vec3(0.299, 0.587, 0.114));
  float val = smoothstep(kThreshold, kThreshold + 0.2, luma);
  return color * val;
}

void main() {
  vec2 uv = FlutterFragCoord().xy / uSize;
  vec4 sourceColor = texture(uTexture, uv);

  vec4 bloomColor = extractBrightColor(sourceColor);
  vec4 finalColor = sourceColor + (bloomColor * kIntensity);

  fragColor = vec4(finalColor.rgb, sourceColor.a);
}

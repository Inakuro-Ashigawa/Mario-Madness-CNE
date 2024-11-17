#version 120
#ifdef GL_ES
    #ifdef GL_FRAGMENT_PRECISION_HIGH
        precision highp float;
    #else
        precision mediump float;
    #endif
#endif

varying float openfl_Alphav;
varying vec4 openfl_ColorMultiplierv;
varying vec4 openfl_ColorOffsetv;
varying vec2 openfl_TextureCoordv;

uniform bool openfl_HasColorTransform;
uniform vec2 openfl_TextureSize;
uniform sampler2D bitmap;
uniform bool hasTransform;
uniform bool hasColorTransform;

uniform vec3 iResolution; // Added uniform for resolution
uniform float time;
uniform vec4 _camSize;

vec4 flixel_texture2D(sampler2D bitmap, vec2 coord) {
    vec4 color = texture2D(bitmap, coord);
    if (!hasTransform) {
        return color;
    }

    if (color.a == 0.0) {
        return vec4(0.0, 0.0, 0.0, 0.0);
    }

    if (!hasColorTransform) {
        return color * openfl_Alphav;
    }

    color = vec4(color.rgb / color.a, color.a);

    mat4 colorMultiplier = mat4(0);
    colorMultiplier[0][0] = openfl_ColorMultiplierv.x;
    colorMultiplier[1][1] = openfl_ColorMultiplierv.y;
    colorMultiplier[2][2] = openfl_ColorMultiplierv.z;
    colorMultiplier[3][3] = openfl_ColorMultiplierv.w;

    color = clamp(openfl_ColorOffsetv + (color * colorMultiplier), 0.0, 1.0);

    if (color.a > 0.0) {
        return vec4(color.rgb * color.a * openfl_Alphav, color.a * openfl_Alphav);
    }
    return vec4(0.0, 0.0, 0.0, 0.0);
}

float map(float value, float min1, float max1, float min2, float max2) {
    return min2 + (value - min1) * (max2 - min2) / (max1 - min1);
}

vec2 getCamPos(vec2 pos) {
    vec4 size = _camSize / vec4(openfl_TextureSize, openfl_TextureSize);
    return vec2(map(pos.x, size.x, size.x + size.z, 0.0, 1.0), map(pos.y, size.y, size.y + size.w, 0.0, 1.0));
}

vec2 camToOg(vec2 pos) {
    vec4 size = _camSize / vec4(openfl_TextureSize, openfl_TextureSize);
    return vec2(map(pos.x, 0.0, 1.0, size.x, size.x + size.z), map(pos.y, 0.0, 1.0, size.y, size.y + size.w));
}

vec4 textureCam(sampler2D bitmap, vec2 pos) {
    return flixel_texture2D(bitmap, camToOg(pos));
}

vec3 mod289(vec3 x) {
    return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec2 mod289(vec2 x) {
    return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec3 permute(vec3 x) {
    return mod289(((x * 34.0) + 1.0) * x);
}

float snoise(vec2 v) {
    const vec4 C = vec4(0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439);
    vec2 i = floor(v + dot(v, C.yy));
    vec2 x0 = v - i + dot(i, C.xx);

    vec2 i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
    vec4 x12 = x0.xyxy + C.xxzz;
    x12.xy -= i1;

    i = mod289(i);
    vec3 p = permute(permute(i.y + vec3(0.0, i1.y, 1.0)) + i.x + vec3(0.0, i1.x, 1.0));

    vec3 m = max(0.5 - vec3(dot(x0, x0), dot(x12.xy, x12.xy), dot(x12.zw, x12.zw)), 0.0);
    m = m * m;
    m = m * m;

    vec3 x = 2.0 * fract(p * C.www) - 1.0;
    vec3 h = abs(x) - 0.5;
    vec3 ox = floor(x + 0.5);
    vec3 a0 = x - ox;

    m *= 1.79284291400159 - 0.85373472095314 * (a0 * a0 + h * h);

    vec3 g;
    g.x = a0.x * x0.x + h.x * x0.y;
    g.yz = a0.yz * x12.xz + h.yz * x12.yw;
    return 130.0 * dot(m, g);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord.xy / iResolution.xy; // iResolution now defined as a uniform
    uv = uv * 2.0 - 1.0;
    uv.x *= iResolution.x / iResolution.y;

    float noiseValue = snoise(uv * 10.0 + time * 0.5);
    vec3 color = vec3(0.5 + 0.5 * cos(time + uv.xyx + vec3(0.0, 2.0, 4.0)));
    color *= noiseValue;

    fragColor = vec4(color, 1.0);
}

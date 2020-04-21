#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
uniform vec2 u_position;
uniform vec2 u_dimension;

uniform sampler2D inputTexture;


float random (in float x) {
    return fract(sin(x)*1e4);
}

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float noise (in vec3 p) {
    const vec3 step = vec3(110.0, 241.0, 171.0);

    vec3 i = floor(p);
    vec3 f = fract(p);

    // For performance, compute the base input to a
    // 1D random from the integer part of the
    // argument and the incremental change to the
    // 1D based on the 3D -> 1D wrapping
    float n = dot(i, step);

    vec3 u = f * f * (3.0 - 2.0 * f);
    return mix( mix(mix(random(n + dot(step, vec3(0,0,0))),
                        random(n + dot(step, vec3(1,0,0))),
                        u.x),
                    mix(random(n + dot(step, vec3(0,1,0))),
                        random(n + dot(step, vec3(1,1,0))),
                        u.x),
                u.y),
                mix(mix(random(n + dot(step, vec3(0,0,1))),
                        random(n + dot(step, vec3(1,0,1))),
                        u.x),
                    mix(random(n + dot(step, vec3(0,1,1))),
                        random(n + dot(step, vec3(1,1,1))),
                        u.x),
                u.y),
            u.z);
}



void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec2 translate = vec2(st.x, 1-st.y);
    st = translate;

    vec2 xPositions = vec2(u_position.x, u_position.x + u_dimension.x) / u_resolution.xy;
    vec2 yPositions = vec2(u_position.y, u_position.y + u_dimension.y) / u_resolution.xy;

    vec4 color = texture2D(inputTexture, st.xy);

    if (st.x < xPositions.x || st.x > xPositions.y || st.y < yPositions.x || st.y > yPositions.y){
        gl_FragColor = vec4(color.rgb, 1.0);
        return;
    }
    
    vec3 pos = vec3(st*5.0,u_time*0.5);

    vec3 newColor = vec3(noise(pos));

    gl_FragColor = vec4(newColor,0.3);
}
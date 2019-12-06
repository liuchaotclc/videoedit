#extension GL_OES_EGL_image_external : require
precision mediump float;
uniform int orientation;
uniform samplerExternalOES sTexture;
varying vec2 vTextureCoord;

vec2 uv_offset = vec2(0.001388889, 0.000925926);

const float math_pi = 3.141592654;
const float math_e  = 2.718281828;

vec4 black_white(vec2 uv) {
    vec4 color = texture2D(sTexture, uv);
    float colorR = (color.r + color.g + color.b) / 3.0;
    float colorG = (color.r + color.g + color.b) / 3.0;
    float colorB = (color.r + color.g + color.b) / 3.0;
    return vec4(colorR, colorG, colorB, color.a);
}

void main(void)
{

	vec2 uv = vTextureCoord.xy;
    if (orientation != 0 && orientation != 180) {
    	if (uv.x < 0.2 || uv.x > 0.8) {
    		gl_FragColor = black_white(uv);
    	} else {
    		gl_FragColor = texture2D(sTexture, vec2(uv.x- 0.2, uv.y));
    	}
    } else {
    	if (uv.y < 0.2 || uv.y > 0.8) {
    		gl_FragColor = black_white(uv);
    	} else {
    		gl_FragColor = texture2D(sTexture, vec2(uv.x, uv.y - 0.2));
    	}
    }
}
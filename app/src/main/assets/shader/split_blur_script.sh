#extension GL_OES_EGL_image_external : require
precision mediump float;
uniform int orientation;
uniform samplerExternalOES sTexture;
varying vec2 vTextureCoord;

vec2 uv_offset = vec2(0.001388889, 0.000925926);

const float math_pi = 3.141592654;
const float math_e  = 2.718281828;

vec4 blurN(vec2 uv, int n, float sigma) {
    vec4 c = vec4(0.0);
    float weight_mul = -1.0 / (2.0 * sigma * sigma);
    float sum = 0.00000001;
    for (int i=-n; i<=n; i++) {
        for (int j=-n; j<=n; j++) {
            vec2 pos = clamp(uv + uv_offset * vec2(float(i), float(j)), 0.0, 1.0);
            vec4 pos_c = texture2D(sTexture, pos);
            float weight = pow(math_e, dot(pos, pos) * weight_mul);

            sum += weight;
            c += pos_c * weight;
        }
    }
    return c / sum;
}

void main(void)
{
	vec2 uv = vTextureCoord.xy;
    if (orientation != 0 && orientation != 180) {
    	if (uv.x < 0.2 || uv.x > 0.8) {
    		gl_FragColor = blurN(uv, 5, 2.0);
    	} else {
    		gl_FragColor = texture2D(sTexture, vec2(uv.x- 0.2, uv.y));
    	}
    } else {
    	if (uv.y < 0.2 || uv.y > 0.8) {
    		gl_FragColor = blurN(uv, 5, 2.0);
    	} else {
    		gl_FragColor = texture2D(sTexture, vec2(uv.x, uv.y - 0.2));
    	}
    }
}
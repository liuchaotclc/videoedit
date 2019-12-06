#extension GL_OES_EGL_image_external : require
precision mediump float;
uniform int orientation;
uniform samplerExternalOES sTexture;
varying vec2 vTextureCoord;

void main(void)
{

	vec2 uv = vTextureCoord.xy;
    if (orientation != 0 && orientation != 180) {
        if (uv.x <= 0.33) {
	        gl_FragColor = texture2D(sTexture, vec2(uv.x + 0.33, uv.y));
	    } else if (uv.x <= 0.66){
	        gl_FragColor = texture2D(sTexture, vec2(uv.x, uv.y));
	    } else {
	        gl_FragColor = texture2D(sTexture, vec2(uv.x - 0.33, uv.y));
	    }
    } else {
        if (uv.y <= 0.33) {
	        gl_FragColor = texture2D(sTexture, vec2(uv.x, uv.y + 0.33));
	    } else if (uv.y <= 0.66){
	        gl_FragColor = texture2D(sTexture, vec2(uv.x, uv.y));
	    } else {
	        gl_FragColor = texture2D(sTexture, vec2(uv.x, uv.y - 0.33));
	    }
    }
}
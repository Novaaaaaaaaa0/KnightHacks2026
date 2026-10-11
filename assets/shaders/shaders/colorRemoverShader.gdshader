shader_type canvas_item;

uniform float threshold : hint_range(0.0, 0.5) = 0.1;
uniform bool make_transparent = false;
uniform bool collectedRed = false;
uniform bool collectedBlue = false;
uniform bool collectedGreen = false;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    bool temp = true;
	bool is_red = (tex_color.r > tex_color.g + threshold) && (tex_color.r > tex_color.b + threshold);
	bool is_green = (tex_color.g > tex_color.r + threshold) && (tex_color.g > tex_color.b + threshold);
	bool is_blue = (tex_color.b > tex_color.r + threshold) && (tex_color.b > tex_color.g + threshold);
	
	if (collectedBlue == true){
		COLOR = COLOR;
	} else if (collectedGreen == true){
		if (is_red)
			COLOR = vec4(COLOR.r, COLOR.g, (COLOR.r+COLOR.g)/3.5, COLOR.a);
		else if (is_green)
			COLOR = vec4(COLOR.r, COLOR.g, 0.0, COLOR.a);
		else if (is_blue)
			COLOR = vec4((COLOR.r+COLOR.g)/5.5, (COLOR.r+COLOR.g)/1.5, 0.0, COLOR.a);
	} else if (collectedRed == true) {
		if (is_red)
			COLOR = vec4(COLOR.r, (COLOR.g + COLOR.b)/2.0, (COLOR.g + COLOR.b)/2.0, COLOR.a); 
		else 
			COLOR = vec4((COLOR.r/5.5), 0.0, 0.0, COLOR.a);
    } else {
        if (make_transparent) {
            COLOR = vec4(0.0, 0.0, 0.0, 0.0);
        } else {
            // Convert non-red pixels to grayscale
            float gray = dot(tex_color.rgb, vec3(0.299, 0.587, 0.114));
            COLOR = vec4(vec3(gray), tex_color.a);
        }
    }
}
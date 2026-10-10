shader_type canvas_item;

uniform float threshold_r: hint_range(0.0, 1.0);
uniform float threshold_g: hint_range(0.0, 1.0);
uniform float threshold_b: hint_range(0.0, 1.0);
uniform float threshold: hint_range(0.0, 10.0);

uniform vec3 spare_color: source_color;
uniform float tolerance: hint_range(0.0, 1.0);

void fragment() {
	vec3 orig_color = texture(TEXTURE,UV).rgb;
	// Grayscale control
	float r = COLOR.r + threshold_r;
	float g = COLOR.g + threshold_g;
	float b = COLOR.g + threshold_b;
	float color = r * g * b;
	color = clamp(color,0.,color-threshold);
	COLOR.rgb = vec3(color);
	
	// Spare color control
	// difference between target color and original texture color
	float diff = distance(spare_color,orig_color);
	// create mask for selected color
	float spare_mask = diff > tolerance ? 0. : 1.;
	
	COLOR.rgb = mix(vec3(color),spare_color,spare_mask);
}
#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
	#define MY_HIGHP_OR_MEDIUMP highp
#else
	#define MY_HIGHP_OR_MEDIUMP mediump
#endif

// change this variable name to your Edition's name
// YOU MUST USE THIS VARIABLE IN THE vec4 effect AT LEAST ONCE
// ^^ CRITICALLY IMPORTANT (IDK WHY)
extern MY_HIGHP_OR_MEDIUMP vec2 mirrored;

extern MY_HIGHP_OR_MEDIUMP number dissolve;
extern MY_HIGHP_OR_MEDIUMP number time;
extern MY_HIGHP_OR_MEDIUMP vec4 texture_details;
extern MY_HIGHP_OR_MEDIUMP vec2 image_details;
extern bool shadow;
extern MY_HIGHP_OR_MEDIUMP vec4 burn_colour_1;
extern MY_HIGHP_OR_MEDIUMP vec4 burn_colour_2;

// the following four vec4 are (as far as I can tell) required and shouldn't be changed

vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv)
{
    if (dissolve < 0.001) {
        return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, shadow ? tex.a*0.3: tex.a);
    }

    float adjusted_dissolve = (dissolve*dissolve*(3.-2.*dissolve))*1.02 - 0.01; //Adjusting 0.0-1.0 to fall to -0.1 - 1.1 scale so the mask does not pause at extreme values

	float t = time * 10.0 + 2003.;
	vec2 floored_uv = (floor((uv*texture_details.ba)))/max(texture_details.b, texture_details.a);
    vec2 uv_scaled_centered = (floored_uv - 0.5) * 2.3 * max(texture_details.b, texture_details.a);
	
	vec2 field_part1 = uv_scaled_centered + 50.*vec2(sin(-t / 143.6340), cos(-t / 99.4324));
	vec2 field_part2 = uv_scaled_centered + 50.*vec2(cos( t / 53.1532),  cos( t / 61.4532));
	vec2 field_part3 = uv_scaled_centered + 50.*vec2(sin(-t / 87.53218), sin(-t / 49.0000));

    float field = (1.+ (
        cos(length(field_part1) / 19.483) + sin(length(field_part2) / 33.155) * cos(field_part2.y / 15.73) +
        cos(length(field_part3) / 27.193) * sin(field_part3.x / 21.92) ))/2.;
    vec2 borders = vec2(0.2, 0.8);

    float res = (.5 + .5* cos( (adjusted_dissolve) / 82.612 + ( field + -.5 ) *3.14))
    - (floored_uv.x > borders.y ? (floored_uv.x - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y > borders.y ? (floored_uv.y - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.x < borders.x ? (borders.x - floored_uv.x)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y < borders.x ? (borders.x - floored_uv.y)*(5. + 5.*dissolve) : 0.)*(dissolve);

    if (tex.a > 0.01 && burn_colour_1.a > 0.01 && !shadow && res < adjusted_dissolve + 0.8*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
        if (!shadow && res < adjusted_dissolve + 0.5*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
            tex.rgba = burn_colour_1.rgba;
        } else if (burn_colour_2.a > 0.01) {
            tex.rgba = burn_colour_2.rgba;
        }
    }

    return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, res > adjusted_dissolve ? (shadow ? tex.a*0.3: tex.a) : .0);
}

number hue(number s, number t, number h)
{
	number hs = mod(h, 1.)*6.;
	if (hs < 1.) return (t-s) * hs + s;
	if (hs < 3.) return t;
	if (hs < 4.) return (t-s) * (4.-hs) + s;
	return s;
}

vec4 RGB(vec4 c)
{
	if (c.y < 0.0001)
		return vec4(vec3(c.z), c.a);

	number t = (c.z < .5) ? c.y*c.z + c.z : -c.y*c.z + (c.y+c.z);
	number s = 2.0 * c.z - t;
	return vec4(hue(s,t,c.x + 1./3.), hue(s,t,c.x), hue(s,t,c.x - 1./3.), c.w);
}

vec4 HSL(vec4 c)
{
	number low = min(c.r, min(c.g, c.b));
	number high = max(c.r, max(c.g, c.b));
	number delta = high - low;
	number sum = high+low;

	vec4 hsl = vec4(.0, .0, .5 * sum, c.a);
	if (delta == .0)
		return hsl;

	hsl.y = (hsl.z < .5) ? delta / sum : delta / (2.0 - sum);

	if (high == c.r)
		hsl.x = (c.g - c.b) / delta;
	else if (high == c.g)
		hsl.x = (c.b - c.r) / delta + 2.0;
	else
		hsl.x = (c.r - c.g) / delta + 4.0;

	hsl.x = mod(hsl.x / 6., 1.);
	return hsl;
}

float EaseQuartOut(float t) 
{
return 1.0 - ((1.0 - t)*(1.0 - t)*(1.0 - t)*(1.0 - t));
}

// this is what actually changes the look of card
vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{

	vec2 uv = (((texture_coords)*(image_details)) - texture_details.xy*texture_details.ba)/texture_details.ba;

    float value = EaseQuartOut((1.0 - abs((uv.x * 2.0) - 1.0))) * EaseQuartOut((1.0 - abs((uv.y * 2.0) - 1.0)));

	texture_coords.x += sin(texture_coords.y * 50 + (mirrored.r * 3) + mirrored.g) * 0.003 * value;
    texture_coords.y += sin(texture_coords.y * 46 + (mirrored.r * 2) + (mirrored.g * 1.141) + 1.4203) * 0.003 * value;

    // turns the texture into pixels
    vec4 tex = Texel(texture, texture_coords);

    // generic shimmer copied straight from negative_shine.fs
    number low = max(tex.b, min(tex.r, tex.g));
    number high = min(tex.b, max(tex.r, tex.g));
	number delta = high-low -0.1;

    number fac = 1.1 + 0.9*sin(11.*uv.x+4.32*uv.y + mirrored.r*12. + cos(mirrored.r*5.3 + uv.y*4.2 - uv.x*4.));
    number fac2 = 0.7 + 0.5*sin(8.*uv.x+2.32*uv.y + mirrored.r*5. - cos(mirrored.r*2.3 + uv.x*8.2));
    number fac3 = 0.7 + 0.5*sin(10.*uv.x+5.32*uv.y + mirrored.r*6.111 + sin(mirrored.r*5.3 + uv.y*3.2));
    number fac4 = 0.7 + 0.5*sin(3.*uv.x+2.32*uv.y + mirrored.r*8.111 + sin(mirrored.r*1.3 + uv.y*11.2));
    number fac5 = sin(0.8*16.*uv.x+5.32*uv.y + mirrored.r*12. + cos(mirrored.r*5.3 + uv.y*4.2 - uv.x*4.));

    number maxfac = 0.7*max(max(fac, max(fac2, max(fac3,0.0))) + (fac+fac2+fac3*fac4), 0.);

    // normally this would have both a tex.b and tex.r for this segement but
    // it made the card look rainbow
    vec4 tex2 = HSL(tex);

    tex.a *= 0.85 + (0.15 * (1-tex2.b));

	tex.r += (-delta + delta*maxfac*(0.0 - fac5*0.27) - 0.1) * (0.2 + 0.8 * (tex2.b) * (tex2.b));
	tex.g += (-delta + delta*maxfac*(0.2 - fac5*0.27) - 0.1) * (0.2 + 0.8 * (tex2.b) * (tex2.b));
    tex.b += (-delta + delta*maxfac*(0.2 - fac5*0.27) - 0.1) * (0.2 + 0.8 * (tex2.b) * (tex2.b));

	tex.r = tex.r*0.8 + (0.0001*mirrored.r);
	tex.g = tex.g*1.0 + (0.0001*mirrored.r);
	tex.b = tex.b*1.1 + (0.0001*mirrored.r);

    tex.rgb *= 1 + 0.2 * (1-tex2.b);
    // required
	return dissolve_mask(tex*colour, texture_coords, uv);
}


// for transforming the card while your mouse is on it
extern MY_HIGHP_OR_MEDIUMP vec2 mouse_screen_pos;
extern MY_HIGHP_OR_MEDIUMP float hovering;
extern MY_HIGHP_OR_MEDIUMP float screen_scale;

#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    if (hovering <= 0.){
        return transform_projection * vertex_position;
    }
    float mid_dist = length(vertex_position.xy - 0.5*love_ScreenSize.xy)/length(love_ScreenSize.xy);
    vec2 mouse_offset = (vertex_position.xy - mouse_screen_pos.xy)/screen_scale;
    float scale = 0.2*(-0.03 - 0.3*max(0., 0.3-mid_dist))
                *hovering*(length(mouse_offset)*length(mouse_offset))/(2. -mid_dist);

    return transform_projection * vertex_position + vec4(0,0,0,scale);
}
#endif
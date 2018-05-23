extern number t;
vec4 effect(vec4 colour, Image img, vec2 txy, vec2 sxy)
{
	vec4 pixel = Texel(img, txy);
	return vec4(pow(cos(sxy.x/20+t),2),pow(sin(sxy.y/20+t),2),abs(1/(1+tan(length(sxy/20)+t))),pixel.a);
}
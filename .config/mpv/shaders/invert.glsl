
//!HOOK MAIN
//!BIND HOOKED
//!DESC Invert Colors
vec4 hook() {
    vec4 c = HOOKED_tex(HOOKED_pos);
    c.rgb = 1.0 - c.rgb;
    return c;
}

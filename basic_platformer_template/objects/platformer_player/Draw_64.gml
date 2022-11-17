fps_low = min(fps_low, fps_real);

var _dy = 20;
#macro NEWLINE _dy += 20

draw_text(20, _dy, "fps: " + string(fps_low)); NEWLINE;
draw_text(20, _dy, "entities: " + string(instance_number(__entity))); NEWLINE;
draw_text(20, _dy, "vx: " + string(velocity_x)); NEWLINE;
draw_text(20, _dy, "vy: " + string(velocity_y)); NEWLINE;
draw_text(20, _dy, "hor: " + string(on_horizontal)); NEWLINE;
draw_text(20, _dy, "ver: " + string(on_vertical)); NEWLINE;
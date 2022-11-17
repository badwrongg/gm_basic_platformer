var _width = display_get_width(),
	_height = display_get_height()
	
if (_width > _height)
{
	aspect = _height/_width;
	prefer_width = true;
}
else
{
	aspect = _width/_height;
	prefer_width = false;
}

camera_destroy(VIEW);
var _cam = camera_create();
view_set_camera(0, _cam);	

function update_follow()
{
	if instance_exists(follow)
	{
		follow_x = follow.x;
		follow_y = follow.y;
		return;
	}
	
	follow = instance_nearest(x, y, follow_object);
}
	
function update_view()
{
	increment_zoom((mouse_wheel_down() - mouse_wheel_up()) * 0.5);
	
	if (prefer_width)
	{
		width  = VIEW_WIDTH * zoom &~ 1;
		height = width * aspect &~ 1;
	}
	else
	{
		height = VIEW_HEIGHT * zoom &~ 1;	
		width  = height * aspect &~ 1;
	}
	
	width_half  = width  >> 1;
	height_half = height >> 1;
	
	x = clamp(follow_x, width_half,  room_width  - width_half);
	y = clamp(follow_y, height_half, room_height - height_half);	
	
	camera_set_view_size(VIEW, width, height);
	camera_set_view_pos(VIEW, x - width_half, y - height_half);	
}
		
function set_position(_x, _y)
{
	x = _x;
	y = _y;
	update_view();
}

function increment_zoom(_increment)
{
	zoom = clamp(zoom + _increment * ZOOM_SPEED, ZOOM_MIN, ZOOM_MAX);	
}

function set_zoom(_zoom)
{	
	zoom = clamp(_zoom, ZOOM_MIN, ZOOM_MAX);
}
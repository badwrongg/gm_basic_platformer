function init_window(_fullscreen)
{
	var _width  = display_get_width(),
		_height = display_get_height();
		
	if (_width > _height)
		display_set_gui_size(GUI_WIDTH, GUI_WIDTH * _height/_width);
	else 
		display_set_gui_size(GUI_HEIGHT * _width/_height, GUI_HEIGHT); ;
	
	window_set_fullscreen(_fullscreen);
	window_set_size(_width, _height);
	surface_resize(application_surface, _width, _height);
}
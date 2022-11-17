#region Locomotion

	var _list = ds_list_create(),
		_x_axis = keyboard_check(ord("D")) - keyboard_check(ord("A")),
		_y_axis = keyboard_check(ord("S")) - keyboard_check(ord("W")),
		_velocity_x = 0,
		_velocity_y = 0;
	
	if (_x_axis != 0 || _y_axis != 0)
	{
		var _dir = arctan2(_y_axis, _x_axis);
		_velocity_x = cos(_dir) * 6;
		_velocity_y = sin(_dir) * 6;
	}
	
#endregion

#region Horizontal move/collisions

	x += _velocity_x;
	var _collisions = instance_place_list(x + sign(_velocity_x), y, __collider, _list, false);
	
	if (_collisions)
	{
		var _resolved_x = x;
		if (_velocity_x > 0)
		{
			// Loop through collisions and find the min x value
			for (var _i = 0; _i < _collisions; _i++)
				_resolved_x = min(_resolved_x, _list[| _i].bbox_left + x - bbox_right);
		}
		else if (_velocity_x < 0)
		{
			// Loop through collisions and find the max x value
			for (var _i = 0; _i < _collisions; _i++)
				_resolved_x = max(_resolved_x, _list[| _i].bbox_right + x - bbox_left);
		}
		x = _resolved_x;
	}	
	
#endregion

#region Vertical move/collisions

	y += _velocity_y;
	ds_list_clear(_list);
	_collisions = instance_place_list(x, y + sign(_velocity_y), __collider, _list, false);

	if (_collisions)
	{
		var _resolved_y = y;
		if (_velocity_y > 0)
		{
			// Loop through collisions and find the min y value
			for (var _i = 0; _i < _collisions; _i++)
				_resolved_y = min(_resolved_y, _list[| _i].bbox_top + y - bbox_bottom);	
		}
		else if (_velocity_y < 0)
		{
			// Loop through collisions and find the max y value
			for (var _i = 0; _i < _collisions; _i++)
				_resolved_y = max(_resolved_y,_list[| _i].bbox_bottom + y - bbox_top);
		}
		y = _resolved_y;
	}

	ds_list_destroy(_list);
	
#endregion


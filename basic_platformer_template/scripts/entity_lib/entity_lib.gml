function entity_event_tick(_tick)
{
	return true;	
}

function entity_move_collide(_velocity_x, _velocity_y)
{
	// Counters
	on_vertical   -= sign(on_vertical);
	on_horizontal -= sign(on_horizontal);
	
	// Basic move and collision state for a platformer entity
	// Note, do vertical first to account for one-way platform drop through
	
	// ********** Vertical ****************************** //
	y += _velocity_y;
	ds_list_clear(collision_list);
	_collisions = instance_place_list(x, y + sign(_velocity_y), __collider, collision_list, false);

	if (_collisions)
	{
		var _resolved_y = y;
		if (_velocity_y > 0)
		{
			// Loop through collisions and find the min y value
			for (var _i = 0; _i < _collisions; _i++)
				_resolved_y = collision_list[| _i].collide_bottom(id, _resolved_y);
		}
		else if (_velocity_y < 0)
		{
			// Loop through collisions and find the max y value
			for (var _i = 0; _i < _collisions; _i++)
				_resolved_y = collision_list[| _i].collide_top(id, _resolved_y);
		}
		
		// If a collision was resolved then set vertical collision direction
		if (_resolved_y != y)
			on_vertical = sign(_velocity_y) * C_ON_VERTICAL_FRAMES;
		
		y = _resolved_y;
	}
	
	// ********** Horizontal ****************************** //
	x += _velocity_x;
	ds_list_clear(collision_list);
	var _collisions = instance_place_list(x + sign(_velocity_x), y, __collider, collision_list, false);
	
	if (_collisions)
	{
		var _resolved_x = x;
		if (_velocity_x > 0)
		{
			// Loop through collisions and find the min x value
			for (var _i = 0; _i < _collisions; _i++)
				_resolved_x = collision_list[| _i].collide_right(id, _resolved_x);
		}
		else if (_velocity_x < 0)
		{
			// Loop through collisions and find the max x value
			for (var _i = 0; _i < _collisions; _i++)
				_resolved_x = collision_list[| _i].collide_left(id, _resolved_x);
		}
		
		// If a collision was resolved then set horizontal collision direction
		if (x != _resolved_x)
			on_horizontal = sign(_velocity_x) * C_ON_HORIZONTAL_FRAMES;
			
		x = _resolved_x;
	}
}
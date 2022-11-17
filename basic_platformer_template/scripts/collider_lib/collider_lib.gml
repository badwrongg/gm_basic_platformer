function collide_none(_entity, _resolved_position)
{
	return _resolved_position;	
}

#region Solid (box shaped)

	function collide_right_solid(_entity, _resolved_x)
	{
		// Collision occured to the right of the entity, so return the minimum (leftmost) x value
		return min(_resolved_x, bbox_left + _entity.x - _entity.bbox_right);
	}

	function collide_left_solid(_entity, _resolved_x)
	{
		// Collision occured to the left of the entity, so return the maximum (rightmost) x value
		return max(_resolved_x, bbox_right + _entity.x - _entity.bbox_left); 
	}

	function collide_top_solid(_entity, _resolved_y)
	{
		// Collision occured above the entity, so return the maximum (downmost) y value
		return max(_resolved_y, bbox_bottom + _entity.y - _entity.bbox_top);
	}

	function collide_bottom_solid(_entity, _resolved_y)
	{
		// Collision occured below the entity, so return the minimum (upmost) y value
		return min(_resolved_y, bbox_top + _entity.y - _entity.bbox_bottom);	
	}

#endregion

#region One-way Platform

	function collide_bottom_one_way_platform(_entity, _resolved_y)
	{
		// Check if the downward movement passed through the top of the one-way platform
		if (_entity.yprevious + _entity.bbox_bottom - _entity.y <= bbox_top)
			return min(_resolved_y, bbox_top + _entity.y - _entity.bbox_bottom);
		
		return _resolved_y;
	}

#endregion

#region Slopes

	function collide_left_slope(_entity, _resolved_x)
	{
		// If entity is below collider bbox always collide
		// or if entity is to the right and this instance is not flipped (i.e., image_xscale)
		if (_entity.bbox_bottom > bbox_bottom || (image_xscale > 0 && _entity.bbox_right > bbox_right)) 		
			return max(_resolved_x, bbox_right + _entity.x - _entity.bbox_left);
	
		collide_slope_set_entity_y(_entity)

		return _resolved_x;
	}

	function collide_right_slope(_entity, _resolved_x)
	{
		// If entity is below collider bbox always collide
		// or if entity is to the left and this instance is not flipped (i.e., image_xscale)
		if (_entity.bbox_bottom > bbox_bottom || (image_xscale < 1 && _entity.bbox_left < bbox_left))
			return min(_resolved_x, _entity.x - _entity.bbox_right + bbox_left);
	
		collide_slope_set_entity_y(_entity);
	
		return _resolved_x;
	}

	function collide_top_slope(_entity, _resolved_y)
	{
		if (_entity.bbox_bottom > bbox_bottom)
			return collide_top_solid(_entity, _resolved_y);
	
		return collide_bottom_slope(_entity, _resolved_y);
	}

	function collide_bottom_slope(_entity, _resolved_y)
	{	
		// Get the inverse lerp position of the left or right bottom corner of the entity
		var _pos = 0.5;
		if (image_xscale > 0)
			_pos = clamp((_entity.bbox_right - bbox_left) / (bbox_right - bbox_left), 0, 1);
		else if (image_xscale < 0)
			_pos = 1 - clamp((_entity.bbox_left - bbox_left) / (bbox_right - bbox_left), 0, 1);
	
		// Lerp between the bottom and top of the bbox
		return min(_resolved_y, _entity.y - _entity.bbox_bottom + lerp(bbox_bottom, bbox_top, _pos));		
	}

	function collide_slope_set_entity_y(_entity)
	{
		// Get the inverse lerp position of the left or right bottom corner of the entity
		var _pos = 0.5;
		if (image_xscale > 0)
			_pos = clamp((_entity.bbox_right - bbox_left) / (bbox_right - bbox_left), 0, 1);
		else if (image_xscale < 0)
			_pos = 1 - clamp((_entity.bbox_left - bbox_left) / (bbox_right - bbox_left), 0, 1);
	
		// Lerp between the bottom and top of the bbox
		_entity.y = min(_entity.y + C_SLOPE_ATTRACT_RANGE, _entity.y - _entity.bbox_bottom + lerp(bbox_bottom, bbox_top, _pos));
	}

#endregion
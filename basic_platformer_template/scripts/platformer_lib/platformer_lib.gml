function platformer_event_tick(_tick)
{
	// Counters
	jump_remember = jump_remember >> 1;
	
	// Execute states
	active_state();
	move_collide_state(velocity_x * _tick, velocity_y * _tick);	
}

function platformer_locomotion()
{
	// Primary locomotion state for a platformer character
	
	var _x_axis  = keyboard_check(ord("D")) - keyboard_check(ord("A")),
		_x_speed = _x_axis * move_acceleration,
		_jump_held = keyboard_check(vk_space),
		_down_held = keyboard_check(ord("S"));
	
	// Feels snappier
	if (keyboard_check_pressed(vk_space))
		jump_remember = C_JUMP_REMEMBER_FRAMES;
	
	// Primary states are on the ground and airborn, which are indicated by on_vertical
	if (on_vertical)
	{
		// Air jump is restored when touching the ground
		jump_count = jump_air_count;
		
		// Ground state
		if (_down_held && _jump_held)
		{
			// Drop through one-way platform
			y += C_COLLISION_ONE_WAY_MOVE;
			yprevious += C_COLLISION_ONE_WAY_MOVE; 
			// Setting yprevious is how we "sneak" through the platform in a very simple way

			// Ensure velocity_y is not zero and positive
			velocity_y = max(C_COLLISION_ONE_WAY_BUFFER, velocity_y);
			jump_remember = 0;
		}
		else if (jump_remember)
		{
			// Normal jump from the ground
			velocity_y = -jump_power;
			on_vertical = 0;
			jump_remember = 0;
		}
	}
	else
	{
		// Airborn state
		velocity_y = min(velocity_y + C_GRAVITY, C_TERMINAL_VELOCITY); // Apply gravity
		
		// Airborn state consists of touching a wall or not
		if (on_horizontal == 0) // Not on a wall
		{
			_x_speed *= move_air_control;
			
			// Air jump
			if (jump_remember && jump_count)
			{
				velocity_y = -jump_power;
				jump_count--;
				jump_remember = 0;
			} 
			// Variable jump height or hitting a ceiling reduces vertical speed
			else if (!_jump_held && (velocity_y < 0 || on_vertical < 0)) 
				velocity_y *= C_VARIABLE_JUMP_FRICTION;
		}
		else // On a wall
		{			
			if (jump_remember)
			{
				// Wall jump
				var _jump_angle = 90 + sign(on_horizontal) * jump_wall_angle;
				velocity_x = lengthdir_x(jump_wall_power, _jump_angle);
				velocity_y = lengthdir_y(jump_wall_power, _jump_angle);
				on_horizontal = 0;
				jump_remember = 0;
			}
			else if (velocity_y > 0) // Sliding down a wall reduces velocity_y
				velocity_y = min(velocity_y, C_TERMINAL_VELOCITY * C_ON_WALL_FRICTION);
		}	
	}

	if (_x_axis != 0) 
		velocity_x = clamp(velocity_x + _x_speed, -move_speed, move_speed); // Acceleration
	else 
		velocity_x -= sign(velocity_x) * min(abs(velocity_x), C_MOVE_FRICTION); // Deceleration
}
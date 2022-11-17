switch (init_step++)
{
	case 0: // Window 
		init_window(true);
	break;
	
	case 1: // System objects
		window_center();
		instance_create_depth(0, 0, DEPTH_SYSTEM, tut_gamestate);
		instance_create_depth(0, 0, DEPTH_SYSTEM, tut_camera);
	break;
	
	case 2: // Game data
		// TODO Setup game data and load system/player saves, etc.
	break;
	
	case 3: // Game assets
		// TODO Load audio groups and fetch textures, etc.
	break;
	
	default:
		room_goto(load_room);
}
game_paused   = true;
current_state = e_gamestate.none;
// TODO add next_state, previous_state, etc. if needed

function pause_game()
{
	// TODO Pause the game and freeze animations, etc...
	game_paused = true;
}

function unpause_game()
{
	// TODO Unpause game, restore animation speeds, etc...
	game_paused = false;
}

function change_room(_room)
{
	// TODO Unload things, etc.
	pause_game();
	room_goto(_room);
}

enum e_gamestate
{
	none,
	room_load,
	gameplay
	// TODO and others like transition, room_unload, etc.
}

#macro FRAME_SPEED room_speed * delta_time * 0.000001
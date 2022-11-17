/// @description State: Gameplay

var _tick = FRAME_SPEED;

// TODO Might add the option to pause/unpause the game here

if (!game_paused)
{
	with (__entity)
		event_tick(_tick);
}

// TODO Do gamemode stuff, check win conditions, etc. and set state accordingly
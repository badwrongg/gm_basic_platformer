// Stores collision instances
collision_list = ds_list_create();

// These act as counters and indicate collision direction
on_vertical   = 0;
on_horizontal = 0;

// Binds
event_tick = method(id, event_tick);
move_collide_state = method(id, move_collide_state);
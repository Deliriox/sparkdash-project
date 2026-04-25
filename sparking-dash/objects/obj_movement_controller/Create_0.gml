player_base_speed = 2;
player_speed = player_base_speed;
player_current_march = Player_Speed.March_1;
jump_speed = 23
vel_x = 0;
vel_y = 1;

gravity_force = 1;
terrain_friction = 0.5;
temporal_terrain_friction = terrain_friction;
grounded = false;
grounded_x = x;
grounded_y = y;

change_march_delay = 90;
march_delay_counter = change_march_delay;
is_skidding = false;
skidding_delay = 60;
skidding_delay_counter = skidding_delay;

player_state = Player_State.Iddle;
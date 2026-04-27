player_base_speed = 4;							// Player's minimum speed value.
player_speed = player_base_speed;
player_current_march = Player_Speed.March_1;	// Player's speed levels; March_1, 2, 3.
jump_speed = 23
vel_x = 0;
vel_y = 1;										// Initialized to 1 to keep player on the ground.
player_force = Force.Force_1;					// Player's force to destroye objects; based on speed.

gravity_force = 1;
terrain_friction = 0.5;							// Friction value to reduce player's speed according to terrain.
temporal_terrain_friction = terrain_friction;
grounded = false;								// If player is on the ground.
grounded_x = x;
grounded_y = y;

change_march_delay = 60;						// 1 frame of delay between speed change.
march_delay_counter = change_march_delay;
is_skidding = false;
skid_timer = 30;
skid_counter = skid_timer;

player_state = Player_State.Iddle;				// Player's states; Iddle, Move, Jump & Skidding.
/// @description Insert description here
// You can write your code in this editor
speed_x = 0;
speed_y = 0;
velocity = VELOCITY_PLAYER.VELOCITY_1
player_speed = 1;

//player_speed = clamp(player_speed, 0, 10);
max_speed = 6;
velocity_march_time_1 = 40;
velocity_march_time_2 = 100;
velocity_march_time_3 = 150;
velocity_timer = 0;


jump_speed = -4.5;
jump_max = 2;
jump_count = 0;
jump_hold_frames = 15;
jump_timer = 0;

general_gravity = 0.25;


state = STATE_PLAYER.IDLE;

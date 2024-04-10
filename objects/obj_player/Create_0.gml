/// @description Insert description here
// You can write your code in this editor
move_x = 0;
move_y = 0;
player_speed = 0;

//player_speed = clamp(player_speed, 0, 10);
max_speed = 20;
jump_speed = -2.5;
jump_max = 2;
jump_count = 0;
jump_hold_frames = 15;
jump_timer = 0;
general_gravity = 0.25;

state = STATE_PLAYER.IDLE;

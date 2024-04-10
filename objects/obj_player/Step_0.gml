/// @description Insert description here
// You can write your code in this editor

// *** user inputs ***
var _right_key = keyboard_check(ord("D"));
var _left_key = keyboard_check(ord("A"));
var _jump_key_press = keyboard_check_pressed(vk_space);
var _jump_key_hold = keyboard_check(vk_space);

// *** jump ***
#region
//reset jump
if(place_meeting(x, y+1, obj_wall))
{
	jump_count = 0;
}
else
{
	if(jump_count == 0)
	{
		jump_count = 1;
	}
}
if(_jump_key_press && jump_count < jump_max)
{
	jump_count++;
	jump_timer = jump_hold_frames;
	//switch(player_speed){
	//case 20:
	//move_y = -4;
	//break;
	
	//case 15:
	//move_y = -3;
	//break;
	
	//	case 10:
	//move_y = -2;
	//break;
	
	//	case 5:
	//move_y = -1;
	//break;
	//}
	if(move_y > -5){
	if(player_speed > 0){
		move_y = (jump_speed * (player_speed/2)) * general_gravity;
	}
	else{
		move_y += jump_speed;
	}
	}
	show_debug_message("Jump:" + string(move_y) + "::" + string(jump_speed) + " and " + string(player_speed));
}

//stop jump if button is not being held
if (!_jump_key_hold)
{
	jump_timer = 0;
}

//jump by timer
if(jump_timer > 0)
{
	//move_y = jump_speed;
	//show_debug_message("Jump by timer:" + string(move_y));
	jump_timer--;
}
#endregion

// *** collisions ***
#region
//axis X
if(place_meeting(x + move_x, y, obj_wall))
{
	var _pixel_check = sign(move_x);
	while !place_meeting(x + _pixel_check, y, obj_wall)
	{
		x+= _pixel_check;
	}
	move_x = 0;
}
//axis Y
if(place_meeting(x + move_x, y + move_y, obj_wall))
{
	var _pixel_check = sign(move_y);
	while !place_meeting(x + move_x, y + _pixel_check, obj_wall)
	{
		y+= _pixel_check
	}
	move_y = 0;
}

x += move_x;
y += move_y
#endregion




if(keyboard_check(vk_nokey) && player_speed > 0)
{
	player_speed -= 0.5;
}
else if(keyboard_check(vk_nokey) && player_speed < 0)
{
	player_speed = 0;
}


if((_right_key || _left_key) && player_speed < max_speed)
{
	player_speed += 0.05;
}

move_and_collide(move_x, move_y , obj_wall, 4, 0, 0, player_speed, player_speed);

// *** gravity ***
move_x = (_right_key - _left_key) * player_speed;
move_y += general_gravity;


// *** Player states ***
if(player_speed == 0)
state = STATE_PLAYER.IDLE;

if(player_speed == max_speed)
state = STATE_PLAYER.FULL_SPEED;

//switch(state)
//{
//	case STATE_PLAYER.IDLE:
//	state = STATE_PLAYER.IDLE;
//	break;
	
//	case STATE_PLAYER.CHARGING:
//	state = STATE_PLAYER.CHARGING;
//	break;
	
//	case STATE_PLAYER.FULL_SPEED:
//	state = STATE_PLAYER.FULL_SPEED;
//	break
	
//}

//if (move_x != 0)
//{
//	image_xscale = sign(move_x);
//}

//var distance = target - current;

//if (abs(distance_x) > 0.1) {
//    current += ( target - current ) * speed;
//} else {
//    current = target;
//}
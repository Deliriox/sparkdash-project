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
	speed_y = jump_speed;
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
	//if(speed_y > -5){
	//if(player_speed > 0){
	//	speed_y = (jump_speed * (player_speed/2)) * general_gravity;
	//}
	//else{
	//	speed_y += jump_speed;
	//}
	//}
	//show_debug_message("Jump:" + string(speed_y) + "::" + string(jump_speed) + " and " + string(player_speed));
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
if(place_meeting(x + speed_x, y, obj_wall))
{
	var _pixel_check = sign(speed_x);
	while !place_meeting(x + _pixel_check, y, obj_wall)
	{
		x+= _pixel_check;
	}
	speed_x = 0;
}
//axis Y
if(place_meeting(x + speed_x, y + speed_y, obj_wall))
{
	var _pixel_check = sign(speed_y);
	while !place_meeting(x + speed_x, y + _pixel_check, obj_wall)
	{
		y+= _pixel_check
	}
	speed_y = 0;
}

x += speed_x;
y += speed_y
#endregion

// *** velocity control ***
#region
if((_right_key || _left_key) && player_speed <= max_speed)
{
	if(velocity_timer <= velocity_march_time_1)
	{
		velocity_timer++;
	}
	else if(velocity_timer <= velocity_march_time_2)
	{
		velocity_timer++;
	}
	else if(velocity_timer <= velocity_march_time_3)
	{
		velocity_timer++;
	}
	else if(velocity_timer <= velocity_march_time_4)
	{
		velocity_timer++;
	}

}
//decelerate
else if(keyboard_check(vk_nokey))
{
	if(velocity_timer > 0)
		velocity_timer--;
}
	
if(velocity_timer <= velocity_march_time_1)
{
	player_speed = MARCH_PLAYER.MARCH_1;
}
if(velocity_timer >= velocity_march_time_1 && velocity_timer < velocity_march_time_2)
{
	player_speed = MARCH_PLAYER.MARCH_2;
}
if(velocity_timer >= velocity_march_time_2 && velocity_timer < velocity_march_time_3)
{
	player_speed = MARCH_PLAYER.MARCH_3;
}	
if(velocity_timer >= velocity_march_time_3 && velocity_timer < velocity_march_time_4)
{
	player_speed = MARCH_PLAYER.MARCH_4;
}



if(_right_key)
{
	if(!sign(speed_x) && player_speed > 1)
	{
		//for(var _counter = 0; _counter <3; _counter+=1){
			player_speed -= 2;
		//}
	}
}
if(_left_key)
{
	if(sign(speed_x) && player_speed > 1)
	{
		//for(var _counter = 0; _counter <3; _counter+=1){
			player_speed += 2;
		//}
	}
}

//if(player_speed < max_speed)
//{
	//if(_right_key)
	//{
	//	if(!sign(speed_x) && player_speed > 1)
	//	{
	//		//for(var _counter = 0; _counter <3; _counter+=1){
	//			player_speed -= 1;
	//		//}
	//	}
	//}	
//}
#endregion



//if(keyboard_check(vk_nokey) && player_speed > 0)
//{
//	player_speed -= 0.5;
//}
//else if(keyboard_check(vk_nokey) && player_speed < 0)
//{
//	player_speed = 0;
//}




move_and_collide(speed_x, speed_y , obj_wall, 4, 0, 0, player_speed, player_speed);

// *** gravity ***
speed_x = (_right_key - _left_key) * player_speed;
speed_y += general_gravity;


// *** Player states ***
if(player_speed == 0)
state = STATE_PLAYER.IDLE;

if(player_speed == max_speed)
state = STATE_PLAYER.FULL_SPEED;

//switch(velocity)
//{
//	case 1:
//	max_speed = STATE_PLAYER.IDLE;
//	break;
	
//	case STATE_PLAYER.CHARGING:
//	state = STATE_PLAYER.CHARGING;
//	break;
	
//	case STATE_PLAYER.FULL_SPEED:
//	state = STATE_PLAYER.FULL_SPEED;
//	break
	
//}

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
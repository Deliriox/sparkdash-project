/// @description Insert description here
// You can write your code in this editor
if(keyboard_check(vk_nokey) && player_speed > 0)
{
	player_speed -= 0.1;
}


if((keyboard_check(vk_right) || keyboard_check(vk_left)) && player_speed <= max_speed)
{
	player_speed += 0.1;
}
move_x = keyboard_check(vk_right) - keyboard_check(vk_left);
move_x = move_x * player_speed;
//move_y = keyboard_check(vk_down) - keyboard_check(vk_up);


if(place_meeting(x, y+2, obj_wall))
{
	move_y = 0;
	
	if(keyboard_check(vk_space))
	{
		move_y = -jump_speed;	
	}
	
}
else if(move_y < 10)
{
	move_y += 1;
	
}

move_and_collide(move_x, move_y , obj_wall, 4, 0, 0, player_speed, player_speed);

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
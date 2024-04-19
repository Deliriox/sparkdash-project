/// @description Insert description here
// You can write your code in this editor
if(follow != noone)
{
	position_x = follow.x;
	position_y = follow.y;
}

x += (position_x - x)/20;
y += (position_y - y)/20;

camera_set_view_pos(view_camera[0], x-(camera_width*0.5), y-(camera_height*1.5));
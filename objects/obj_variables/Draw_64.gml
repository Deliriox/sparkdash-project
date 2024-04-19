/// @description Insert description here
// You can write your code in this editor
draw_set_color(c_white);
draw_text(x,y - 10, "speed: " + string(obj_player.player_speed));
draw_text(x,y - 25, "jump: " + string(obj_player.jump_speed));
draw_text(x,y - 40, "move y: " + string(obj_player.speed_y));
draw_text(x,y - 65, "move x: " + string(obj_player.speed_x));
draw_text(x,y - 85, "player state: " + string(obj_player.state));
draw_text(x,y - 105, "velocity timer: " + string(obj_player.velocity_timer));
//draw_text(x,y - 115, "velocity march: " + string(obj_player.velocity_march_time));
draw_text(x,y - 125, "velocity: " + string(obj_player.velocity));

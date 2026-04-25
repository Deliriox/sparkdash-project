var move_count = abs(vel_x);
var move_once = sign((vel_x));

if(round(move_once) != 0) {
	repeat(move_count) {
		var collision_found = check_collision(move_once, 0);
		
		if(!collision_found) {
			x += move_once;		
			
		}
		else {
			vel_x = 0;
			break;
		}
	}
}

move_count = abs(vel_y);
move_once = sign((vel_y));
repeat (move_count)
{
	var collision_found = check_collision(0, move_once);

	if (!collision_found)
	{
		y += move_once;
	}
	else
	{
		vel_y = 0;
		break;
	}
}

if(player_state == Player_State.Iddle)
	PlayerDeceleration(noone);
else if(player_state == Player_State.Move) {
	if(is_skidding) {
		temporal_terrain_friction = player_speed * 2.5;
		PlayerDeceleration(noone);
		skidding_delay_counter--;
		if(skidding_delay_counter <= 0) {
			is_skidding = false;
			skidding_delay_counter = skidding_delay;
			temporal_terrain_friction = terrain_friction;
		}
	}
	else
		PlayerAcceleration();
	
}
	


function PlayerAcceleration() {
	switch(player_current_march) {
		case Player_Speed.March_1:
			player_speed += 0.2;
			if(player_speed >= Player_Speed.March_1) {
					player_speed = Player_Speed.March_1;
					march_delay_counter--;
			}			
			if(march_delay_counter <= 0) {
				player_current_march = Player_Speed.March_2;
				march_delay_counter = change_march_delay;
			}
		break;
		
		case Player_Speed.March_2:
			player_speed += 0.2;
			if(player_speed >= Player_Speed.March_2) {
					player_speed = Player_Speed.March_2;
					march_delay_counter--;
			}			
			if(march_delay_counter <= 0) {
				player_current_march = Player_Speed.March_3;
				march_delay_counter = change_march_delay;
			}		
		break;
		
		case Player_Speed.March_3:
			player_speed += 0.2;
			if(player_speed >= Player_Speed.March_3) {
				player_speed = Player_Speed.March_3;
			}
		break;		
	}	
}

function PlayerDeceleration(_deceleration_value) {
	if(_deceleration_value == noone)
		_deceleration_value = 0.2;
	switch(player_current_march) {
		case Player_Speed.March_1:
			player_speed -= _deceleration_value;
			if(player_speed <= player_base_speed) {
				player_speed = player_base_speed;
			}
		break;
		
		case Player_Speed.March_2:
			player_speed -= _deceleration_value;
			
			if(player_speed <= Player_Speed.March_1) {
				player_current_march = Player_Speed.March_1;
			}		
		break;
		
		case Player_Speed.March_3:
			player_speed -= _deceleration_value;
			
			if(player_speed <= Player_Speed.March_2) {
				player_current_march = Player_Speed.March_2;
			}
		break;		
	}	
}
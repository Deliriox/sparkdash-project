var h_input = right_input - left_input;
var v_input = down_input - up_input;

PlayerStateChange();

if (player_state != Player_State.Sparking) {
	if(h_input != 0 && !is_skidding) {
		if(temporal_terrain_friction != terrain_friction)
			temporal_terrain_friction = terrain_friction;
		PlayerAcceleration();
	}
	else {
		if(player_speed > player_base_speed) {
			PlayerDeceleration();
				
		}
	}
}

#region Sparking.
if (is_spark_charged && player_state != Player_State.Sparking) {	// Time that sparking is hold without use.   
    
    if (sparking_holding_loss <= 0) {
        sparking_holding_loss = sparking_holding;
        is_spark_charged = false;
    }
	else if(!down_input)
		sparking_holding_loss--;
}

if(is_spark_charged && !grounded)							// Activate sparking.  
{
	if(jump_input && player_state != Player_State.Sparking) // If jump then activate sparking.
	{			
		player_state = Player_State.Sparking;
			
		if(h_input != 0 || v_input != 0)
			sparking_dir = point_direction(0, 0, h_input, v_input);
		else {
	        if (obj_player_spark.image_xscale == 1) {
	            sparking_dir = 0;							// Dash Right
	        } else {
	            sparking_dir = 180;							// Dash Left
	        }
		}
		// Sparking variables.
		player_current_march = Player_Speed.March_3;
		player_speed = player_current_march;
		player_force = Force.Force_3;
			
		is_spark_charged = false;
        sparking_holding_loss = sparking_holding;
		// Move immediately after sparking is activaed.
		vel_x = lengthdir_x(player_speed, sparking_dir);
		vel_y = lengthdir_y(player_speed, sparking_dir);
			
		show_debug_message("KEYS: " + string(h_input) + " | DIR: " + string(sparking_dir) + " | VEL: " + string(vel_x));
	}
}

if(player_state == Player_State.Sparking) 
{        
	vel_x = lengthdir_x(player_speed, sparking_dir);
	vel_y = lengthdir_y(player_speed, sparking_dir);
	show_debug_message("KEYS: " + string(h_input) + " | DIR: " + string(sparking_dir) + " | VEL: " + string(vel_x));			
}
#endregion

#region Player's collision and move.
var move_count = abs(vel_x);
var move_once = sign((vel_x));
if(round(move_once) != 0) {
	repeat(move_count) {
		var collision_found = check_collision(move_once, 0);
		
		if(!collision_found) {					// There is no collision.
			x+= move_once						// Advances over X axis.
			colliding = false;
			PlayerShadow();
		}
		else {
			if(!BlockDestructionX(move_once)) {	// Do block destruction if not then Player is stopped.
				player_state = Player_State.Iddle;
				vel_x = 0;
				colliding = true;
				break;
			}
		}			
	}
}

move_count = abs(vel_y);
move_once = sign((vel_y));
repeat (move_count)
{
	var collision_found = check_collision(0, move_once);

	if (!collision_found)						// There is no collision.
	{
		y += move_once;							// Advances over Y axis.
		colliding = false;
		PlayerShadow();
	}
	else {
		if(!BlockDestructionY(move_once)) {		// Do block destruction if not then Player is stopped.
			player_state = Player_State.Iddle;
			vel_y = 0;
			colliding = true;
			break;
		}
	}	
}
#endregion
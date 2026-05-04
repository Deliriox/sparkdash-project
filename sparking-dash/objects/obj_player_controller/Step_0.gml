var _h_input = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var _v_input = keyboard_check(ord("S")) - keyboard_check(ord("W"));

if (player_state != Player_State.Sparking) {
	if(player_state == Player_State.Move) {
		PlayerAcceleration();
	}
	else if(player_state == Player_State.Iddle || !grounded) {
		if(player_speed > player_base_speed)
			PlayerDeceleration();
	}
}

#region Sparking.
if (is_spark_charged && player_state != Player_State.Sparking) {	// Time that sparking is hold without use.
    obj_player_spark.image_blend = c_red;    
    
    if (sparking_holding_loss <= 0) {
        sparking_holding_loss = sparking_holding;
        is_spark_charged = false;
        obj_player_spark.image_blend = c_white;
    }
	else if(!down_input)
		sparking_holding_loss--;
}

if(is_spark_charged && !grounded)			// Activate sparking.  
{
	if(_h_input != 0 || _v_input != 0)		// If there is an input then procced to sparking.
	{
		if(jump_input && player_state != Player_State.Sparking) // If jump then activate sparking.
		{
			show_debug_message("KEYS: " + string(_h_input) + " | DIR: " + string(sparking_dir) + " | VEL: " + string(vel_x));
			obj_player_spark.image_blend = c_green;
			
			player_state = Player_State.Sparking;
			sparking_dir = point_direction(0, 0, _h_input, _v_input);
			player_current_march = Player_Speed.March_3;
			player_speed = player_current_march;
			player_force = Force.Force_3;
			
			is_spark_charged = false;
            sparking_holding_loss = sparking_holding;
		}
	}
}

if(player_state == Player_State.Sparking) 
{        
	vel_x = lengthdir_x(player_speed, sparking_dir);
	vel_y = lengthdir_y(player_speed, sparking_dir);
	show_debug_message("KEYS: " + string(_h_input) + " | DIR: " + string(sparking_dir) + " | VEL: " + string(vel_x));			
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





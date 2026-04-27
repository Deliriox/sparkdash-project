#region Player's collision and move.
var move_count = abs(vel_x);
var move_once = sign((vel_x));
if(round(move_once) != 0) {
	repeat(move_count) {
		var collision_found = check_collision(move_once, 0);
		
		if(!collision_found) {					// There is no collision.
			x += move_once;						// Advances over X axis.
		}
		else {
			if(!BlockDestructionX(move_once)) {	// Do block destruction if not then Player is stopped.
				player_state = Player_State.Iddle;
				vel_x = 0;
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
	}
	else {
		if(!BlockDestructionY(move_once)) {		// Do block destruction if not then Player is stopped.
			vel_y = 0;
			break;
		}
	}	
}
#endregion

if(player_state == Player_State.Iddle)
	PlayerDeceleration();
else if(player_state == Player_State.Move) {
	//if(is_skidding) {
	//	temporal_terrain_friction = player_speed * 1.5;
	//	PlayerDeceleration();
	//	skidding_delay_counter--;
	//	if(skidding_delay_counter <= 0) {
	//		is_skidding = false;
	//		skidding_delay_counter = skidding_delay;
	//		temporal_terrain_friction = terrain_friction;
	//	}
	//}
	//else
		PlayerAcceleration();	
}

// --- Player: STEP EVENT (State Machine Phase) ---
//if (is_skidding) {
    
//    // 1. COUNTDOWN
//    skid_timer--;
    
//    // 2. DECELERATE (The Friction)
//    var _skid_friction = 0.5; 
//    player_speed -= _skid_friction;
    
//    if (player_speed < 0) {
//        player_speed = 0;
//    }
    
//    // 3. MAINTAIN THE TRACK
//    vel_x = sign(image_xscale) * player_speed; 

//    // 4. THE DELAY IS OVER
//    if (skid_timer <= 0) {
        
//        // Switch back to moving
//        player_state = Player_State.Move;
        
//        // Read the actual keyboard input right now
//        var _current_input = keyboard_check(vk_right) - keyboard_check(vk_left);
        
//        if (_current_input != 0) {
//            // They are holding a direction! Snap the sprite that way.
//            image_xscale = _current_input; 
            
//            // Apply the base speed in the new direction
//            player_current_march = Player_Speed.March_1;
//            player_speed = player_base_speed; 
//            delay_counter = change_march_delay;
            
//            vel_x = image_xscale * player_speed;
            
//        } else {
//            // They let go of the keyboard completely during the skid.
//            player_state = Player_State.Iddle; 
//            vel_x = 0;
//        }
        
//        // Turn off the skidding toggle
//        is_skidding = false; 
//    }
//}

#region Player's speed handle.
function PlayerAcceleration() {
	switch(player_current_march) {
		case Player_Speed.March_1:
			player_speed += 0.2;
			player_force = Force.Force_1;
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
			player_force = Force.Force_2;
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
			player_force = Force.Force_3;
			if(player_speed >= Player_Speed.March_3) {
				player_speed = Player_Speed.March_3;
			}
		break;		
	}	
}

function PlayerDeceleration() {

		var _deceleration_value = 0.2;
	switch(player_current_march) {
		case Player_Speed.March_1:
			player_speed -= _deceleration_value;
			player_force = Force.Force_1;
			if(player_speed <= player_base_speed) {
				player_speed = player_base_speed;
			}
		break;
		
		case Player_Speed.March_2:
			player_speed -= _deceleration_value;
			player_force = Force.Force_2;
			if(player_speed <= Player_Speed.March_1) {
				player_current_march = Player_Speed.March_1;
			}		
		break;
		
		case Player_Speed.March_3:
			player_speed -= _deceleration_value;
			player_force = Force.Force_3;
			if(player_speed <= Player_Speed.March_2) {
				player_current_march = Player_Speed.March_2;
			}
		break;		
	}	
}
#endregion
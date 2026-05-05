enum Player_State {
	Iddle = 0,
	Move = 1,
	Jump = 2,
	Skidding = 3,
	Sparking = 4
}

enum Player_Speed {
	March_1 = 10,
	March_2 = 18,
	March_3 = 30
}	

enum Force {
	Force_1 = 1,
	Force_2 = 2,
	Force_3 = 3
}
#region Player's movement.
function PlayerLeft()
{
	// Set skidding when vel is oppositive tu current direction
	if (self.grounded && self.vel_x > 0 && player_current_march > Player_Speed.March_1) {
        self.is_skidding = true;
        
        // Change to your skid sprite here (change name to match yours)
        // sprite_index = spr_player_skid; 
        
        self.left_input = false;
        return;
    }
	is_skidding = false;	

	if (self.grounded)								// Movement on ground.
	{
		self.vel_x = -self.player_speed;
		sprite_index = spr_player_walk;
	}
	else {
		vel_x = lerp(vel_x, -player_speed, 0.1);	// Movement on air.
	}
	obj_player_spark.image_xscale = -1;
	self.left_input = false;
}

function PlayerRight()
{
	if (self.grounded && self.vel_x < 0 && player_current_march > Player_Speed.March_1) {
        self.is_skidding = true;
        
        // Change to your skid sprite here (change name to match yours)
        // sprite_index = spr_player_skid; 
        
        self.right_input = false;
        return;
    }
	
	is_skidding = false;
	if (self.grounded)								// Movement on ground.
	{
		self.vel_x = self.player_speed;
		sprite_index = spr_player_walk;
	}
	else
		vel_x = lerp(vel_x, player_speed, 0.1);		// Movement on air.
	
	obj_player_spark.image_xscale = 1;
	self.right_input = false;
}

function PlayerJump()
{
	if (self.grounded)
	{
		// This sets the Y velocity to negative jump_speed, making the player immediately jump upwards. It
		// will automatically be brought down by the gravity code in the parent's Begin Step event.
		self.vel_y = -self.jump_speed;

		sprite_index = spr_player_jump;
		image_index = 0;				// Reset frame to 0.

		self.grounded = false;

		instance_create_layer(x, bbox_bottom, "Instances", obj_effect_jump);
	
		var _sound = audio_play_sound(snd_jump, 0, 0);
		audio_sound_pitch(_sound, random_range(0.8, 1));
	}
	self.jump_input = false;
}

function PlayerUp()
{    
    if (!keyboard_check(ord("W")) && !keyboard_check(vk_up)) {
        self.up_input = false;
    }
}

function PlayerDown()
{
	if (self.grounded && (player_current_march == Player_Speed.March_2 || player_current_march == Player_Speed.March_3))
	{
		if (keyboard_check(ord("S"))) {
			if(hold_to_chargin_count <= 0) {				// Counter for enable charge after (30). 
				is_spark_charged = true;				
				hold_to_chargin_count = hold_to_chargin;
			}
			else
				hold_to_chargin_count--;
		}			
	}
	self.down_input = false;
}
#endregion

function PlayerShadow() {	
	self.trail_timer--;		
	if (self.trail_timer <= 0) {    
		var ghost = instance_create_depth(x, y, depth + 1, obj_player_shadow);
		ghost.sprite_index = sprite_index;
		ghost.image_index = image_index;
		ghost.image_xscale = image_xscale;
		ghost.image_yscale = image_yscale;    
		self.trail_timer = self.trail_delay;
	}
}

#region Player's speed handle.
function PlayerAcceleration() {
	var acceleration_value = 0.2;
	switch(player_current_march) {
		case Player_Speed.March_1:			
			player_speed += acceleration_value;
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
			player_speed += acceleration_value;
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
			player_speed += acceleration_value;
			player_force = Force.Force_3;
			if(player_speed >= Player_Speed.March_3) {
				player_speed = Player_Speed.March_3;
			}
		break;		
	}	
}

function PlayerDeceleration() {
	var deceleration_value = 0.05;
	switch(player_current_march) {
		case Player_Speed.March_1:
			player_speed -= deceleration_value;
			player_force = Force.Force_1;
			if(player_speed <= player_base_speed) {
				player_speed = player_base_speed;
			}
		break;
		
		case Player_Speed.March_2:
			if(is_skidding)
				temporal_terrain_friction = 0.6;
			deceleration_value = 0.1
			player_speed -= deceleration_value;
			player_force = Force.Force_2;
			if(player_speed <= Player_Speed.March_1) {
				player_current_march = Player_Speed.March_1;
			}		
		break;
		
		case Player_Speed.March_3:
			if(is_skidding)
				temporal_terrain_friction = 0.7;
			deceleration_value = 0.15
			player_speed -= deceleration_value;
			player_force = Force.Force_3;
			if(player_speed <= Player_Speed.March_2) {
				player_current_march = Player_Speed.March_2;
			}
		break;		
	}	
}
#endregion

function PlayerStateChange() {
	if(obj_player_spark.player_state == Player_State.Sparking)
		obj_player_spark.image_blend = c_aqua;
		
	if(obj_player_spark.player_state != Player_State.Sparking &&
	!obj_player_spark.is_spark_charged &&
	(obj_player_spark.player_current_march == Player_Speed.March_1 ||
	obj_player_spark.player_state == Player_State.Iddle))
		obj_player_spark.image_blend = c_white;
		
	if(obj_player_spark.player_state != Player_State.Sparking &&
	!obj_player_spark.is_spark_charged &&
	obj_player_spark.player_current_march == Player_Speed.March_2)
		obj_player_spark.image_blend = c_yellow;
		
	if(obj_player_spark.player_state != Player_State.Sparking &&
	!obj_player_spark.is_spark_charged &&
	obj_player_spark.player_current_march == Player_Speed.March_3)
		obj_player_spark.image_blend = c_blue;
		
	if(obj_player_spark.player_state != Player_State.Sparking &&
	obj_player_spark.is_spark_charged)
		obj_player_spark.image_blend = c_red;
}
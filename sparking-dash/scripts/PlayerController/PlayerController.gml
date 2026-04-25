enum Player_State {
	Iddle = 0,
	Move = 1,
	Jump = 2,
	Skidding = 3
}
enum Player_Speed {
	March_1 = 6,
	March_2 = 10,
	March_3 = 20
}

function PlayerLeft()
{
	if(obj_player_spark.image_xscale == 1)
		is_skidding = true;
	self.vel_x = -self.player_speed;

	if (grounded)
	{
		sprite_index = spr_player_walk;
	}
	else
		return;
	
	left_input = false;
}

function PlayerRight()
{
	if(obj_player_spark.image_xscale == -1)
		is_skidding = true;
	self.vel_x = self.player_speed;

	if (grounded)
	{
		sprite_index = spr_player_walk;
	}
	else
		return;
	
	right_input = false;
}

function PlayerJump()
{
	// This checks if the 'grounded' variable is true, meaning the player is standing on the ground, and can jump.
	if (self.grounded)
	{
		// This sets the Y velocity to negative jump_speed, making the player immediately jump upwards. It
		// will automatically be brought down by the gravity code in the parent's Begin Step event.
		self.vel_y = -self.jump_speed;

		sprite_index = spr_player_jump;
		image_index = 0;				// Reset frame to 0.

		grounded = false;

		// This creates an instance of obj_effect_jump at the bottom of the player's mask. This is the
		// jump VFX animation.
		instance_create_layer(x, bbox_bottom, "Instances", obj_effect_jump);
	
		var _sound = audio_play_sound(snd_jump, 0, 0);
		audio_sound_pitch(_sound, random_range(0.8, 1));
	}
	jump_input = false;
}

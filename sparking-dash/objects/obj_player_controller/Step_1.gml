grounded = check_collision(0, 1);									// Check if player is grounded.

if(round(vel_x) != 0) {
	var friction_applied = sign(vel_x) * temporal_terrain_friction;
	
	if(!grounded)
		friction_applied = friction_applied / 4;					// No friction in air.
	
	vel_x -= friction_applied;										// Frinction on ground.
}
else
	vel_x = 0;
if(!grounded && player_state != Player_State.Sparking)				// Apply gravity when player is not in sparking state.
	vel_y += gravity_force;
	

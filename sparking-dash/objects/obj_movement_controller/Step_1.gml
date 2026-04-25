grounded = check_collision(0, 1);

if(round(vel_x) != 0) {
	var friction_applied = sign(vel_x) * temporal_terrain_friction;
	
	if(!grounded)
		friction_applied = friction_applied / 4;
	
	vel_x -= friction_applied;
}
else
	vel_x = 0;
if(!grounded)	
	vel_y += gravity_force;
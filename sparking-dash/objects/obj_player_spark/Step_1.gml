event_inherited();



if (left_input)
{
	PlayerLeft();
}

if (right_input)
{	
	PlayerRight();
}

if (jump_input)
{	
	PlayerJump();		
}

if (down_input)
{	
	PlayerDown();		
}

if(player_state != Player_State.Sparking) {
	if(abs(vel_x) > 0 && grounded && !colliding) {
		self.player_state = Player_State.Move;
	}
	if(!grounded) {
		self.player_state = Player_State.Jump;
	}
	if(vel_x == 0 && grounded) {
		self.player_state = Player_State.Iddle;
	}
}
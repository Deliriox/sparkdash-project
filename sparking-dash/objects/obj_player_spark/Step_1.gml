event_inherited();

if (jump_input)
{	
	PlayerJump();		
}

if (left_input)
{
	PlayerLeft();
}

if (right_input)
{	
	PlayerRight();
}

if(abs(vel_x) > 0)
		self.player_state = Player_State.Move;
if(!grounded)
		self.player_state = Player_State.Jump;
if(vel_x == 0 && grounded)
		self.player_state = Player_State.Iddle;

//if(!right_input && !left_input && grounded)
//	player_state = Player_State.Iddle;
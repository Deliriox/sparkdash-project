// Check if player is colliding to an object and check if player can destroye it.
function BlockDestructionX(_move_once) {		// For X.
	var block = instance_place(x + _move_once, y, obj_block_parent);
	if(block != noone) {
		if(obj_player_spark.xprevious != obj_player_spark.x) {
			with(block) {
				if(obj_player_spark.player_force >= block_force)
					event_user(0);
				else return false;
			}
			x += _move_once;
			return true;
		}
		return false;
	}
	return false;
}

function BlockDestructionY(_move_once) {		// For Y.
	var block = instance_place(x, y + _move_once, obj_block_parent);
	if(block != noone) {
		if(obj_player_spark.yprevious != obj_player_spark.y) {
			with(block) {
				if(obj_player_spark.player_force >= block_force)
					event_user(0);
				else return false;
			}
			y += _move_once;
			return true;
		}
		return false;
	}
	return false;
}
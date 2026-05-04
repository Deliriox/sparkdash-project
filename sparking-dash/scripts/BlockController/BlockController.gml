// Check if player is colliding to an object and check if player can destroye it.
function BlockDestructionX(_move_once) {		// For X.
	var block = instance_place(x + _move_once, y, obj_block_parent);
	if(block != noone) {
		if (obj_player_spark.player_force >= block.block_force) {
			with(block) {
					event_user(0);
			}
			x += _move_once;
			PlayerShadow();
			return true;
		}
		else
			return false;
	}
	else
		return false;
}

function BlockDestructionY(_move_once) {		// For Y.
	var block = instance_place(x, y + _move_once, obj_block_parent);
	if(block != noone) {
		if (obj_player_spark.player_force >= block.block_force) {
			with(block) {
				event_user(0);
			}
			y += _move_once;
			return true;
		}
		return false;
	}
	return false;
}
draw_set_color(c_white);

draw_text(obj_player_spark.x + 25, obj_player_spark.y + 25, 
"X: " + string(obj_player_spark.x) + " Y: " + string(obj_player_spark.y));

draw_text(obj_player_spark.x - 80, obj_player_spark.y + 25, 
"Speed_X " + string(obj_player_spark.vel_x));

draw_text(obj_player_spark.x - 80, obj_player_spark.y - 55, 
"State " + string(obj_player_spark.player_state));

draw_text(obj_player_spark.x + 70, obj_player_spark.y - 55, 
"March " + string(obj_player_spark.player_current_march));

draw_text(obj_player_spark.x + 70, obj_player_spark.y - 90, 
"Player_Speed " + string(obj_player_spark.player_speed));

draw_text(obj_player_spark.x - 70, obj_player_spark.y - 90, 
"Skidding " + string(obj_player_spark.is_skidding));

draw_text(obj_player_spark.x - 75, obj_player_spark.y - 125, 
"Force " + string(obj_player_spark.player_force));

draw_text(obj_player_spark.x + 75, obj_player_spark.y - 125, 
"Is Charged " + string(obj_player_spark.is_spark_charged));

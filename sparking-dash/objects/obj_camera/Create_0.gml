camera = view_camera[0];

target = obj_player_spark;

deadzone_box_x = target.x - 100;
deadzone_box_y = target.y + 100;



screen_scale = 1.2;

camera_set_view_size(camera, 1920, 1080);
camera_set_view_pos(camera, deadzone_box_x, target.y - round((camera_get_view_height(camera) / screen_scale)));

goal_x = x;
goal_y = y;

cam_width = 1920;
center_x = cam_width / 2; // 960
max_lookahead = 400;     // How far ahead the camera looks
target_lookahead = 0;    // Where the camera WANTS to look
current_lookahead = 0;   // Where the camera CURRENTLY is (used for smooth lerping)

camera_middle_x = round(camera_get_view_width(camera) / 2);

camera_speed = 0.1;

if (instance_exists(target)) {
    var _start_x = target.x - center_x;
    
    // Clamp so the camera doesn't show outside the 19000px room
    _start_x = clamp(_start_x, 0, room_width - cam_width);
    
    // Set the view immediately
    camera_set_view_pos(view_camera[0], _start_x, camera_get_view_y(view_camera[0]));
}
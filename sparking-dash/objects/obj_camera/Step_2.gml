// --- obj_camera: END STEP EVENT ---

if (!instance_exists(target)) exit;

var _cam = view_camera[0];

// 1. THE TRIGGER LOGIC (Fixed)
// Check if the player is actively moving (using native GML)
if (abs(target.x - target.xprevious) > 0.5) { 
    
    // Immediately set the lookahead based purely on facing direction!
    if (target.image_xscale > 0) {
        // Facing Right: Push camera Right (Player slides to the Left of the screen)
        target_lookahead = max_lookahead;  
    } else if (target.image_xscale < 0) {
        // Facing Left: Push camera Left (Player slides to the Right of the screen)
        target_lookahead = -max_lookahead; 
    }
}

// 2. SMOOTH THE MOVEMENT
// Slide the current lookahead toward the target
current_lookahead = lerp(current_lookahead, target_lookahead, 0.05);

// 3. APPLY TO CAMERA
var _target_cam_x = target.x - center_x + current_lookahead;

// Ensure the camera never leaves your 19000px room width
_target_cam_x = clamp(_target_cam_x, 0, room_width - cam_width);

// Move the actual GameMaker viewport
camera_set_view_pos(_cam, _target_cam_x, camera_get_view_y(_cam));
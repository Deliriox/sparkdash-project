// Multiply by 100 because draw_healthbar expects a number between 0 and 100
var _speed_percent = clamp((player_speed / Player_Speed.March_3) * 100, 0, 100);

// Coordinates for the bar on the screen
var _x1 = 20;  // Left edge
var _y1 = 20;  // Top edge
var _x2 = 200; // Right edge (makes the bar 180 pixels wide)
var _y2 = 40;  // Bottom edge (makes the bar 20 pixels tall)

// draw_healthbar(x1, y1, x2, y2, amount, backcol, mincol, maxcol, direction, showback, showborder);
draw_healthbar(_x1, _y1, _x2, _y2, _speed_percent, c_black, c_yellow, c_lime, 0, true, true);
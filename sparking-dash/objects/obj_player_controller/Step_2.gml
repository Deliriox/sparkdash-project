// Flip player sprite based on the direction/velocity.
if (vel_x < 0)
{
	image_xscale = -1;
	image_yscale = 1;
}
else if (vel_x > 0)
{
	image_xscale = 1;
	image_yscale = 1;
}

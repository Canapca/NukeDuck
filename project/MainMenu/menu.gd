extends Control

# I made this small example so you can tear it to pieces and see how it works
# Nothing fancy but it's a start I guess
# The object to have the bricks in the background probably doesn't fit but oh well
# Oh and I know you want to do the menu stuff but right now I'm too tired to actually work
# And making this small nothing burger is somewhat fun and won't break anything
# Also if you're reading this keep in mind that in menu.tscn I moved the entire scene into a external node

# Obviously the little example I did was purely for my own fun, if you wanna get rid of it
# Just remove the color rect and the tile map, also the entiriety of this script it just the example
# So you can nuke it as well

# Also since this is an EXAMPLE I should probably mention
# That this experiment made the mouse not work with buttons
# The problem was the color rect which somehow stole the attention of the mouse
# I had to go to the color rect settings and in mouse had to set it to ignore

var mouse_relative

func _process(_delta: float) -> void:
	mouse_relative = Vector2(get_global_mouse_position().x - (1920 /2), get_global_mouse_position().y - (1080/2))
	$Node.position = mouse_relative / 50
	$NodeX.position = mouse_relative / -100

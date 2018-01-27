extends Spatial

onready var hovercar = $Hovercar

var drive = false
var stop = false
var reverse = false

#driving
#drifting
#stopping
#reversing

func _physics_process(delta):
	if drive:
		hovercar.accelerate()
	elif stop:
		hovercar.brake()
	elif reverse:
		hovercar.reverse()
	
	var angle = 0.0
	if Input.is_key_pressed(KEY_A):
		angle += 1.2
	if Input.is_key_pressed(KEY_D):
		angle -= 1.2
	if angle != 0:
		hovercar.turn(angle * delta)

func _input(event):
	if event.is_action("drive"):
		drive = event.is_pressed()
	elif event.is_action("reverse"):
		if event.is_pressed():
			if hovercar.moving_foward():
				stop = true
			else:
				reverse = true
		else:
			stop = false
			reverse = false
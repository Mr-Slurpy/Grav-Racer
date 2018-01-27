extends Spatial

onready var hovercar = $Hovercar

func _physics_process(delta):
	if Input.is_action_pressed("drive"):
		hovercar.move(Vector3(0, 0, 0.6))
	
	var angle = 0.0
	if Input.is_key_pressed(KEY_A):
		angle += 3.0
	if Input.is_key_pressed(KEY_D):
		angle -= 3.0
	if angle != 0:
		hovercar.turn(angle * delta)
extends Spatial

const pan = 6
const spring = 1.6

onready var hovercar = $"../Hovercar"

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	global_transform.origin = hovercar.global_transform.origin
	
	var desired = Quat(hovercar.global_transform.basis)
	var current = Quat(global_transform.basis)
	var actual = current.slerp(desired, min(delta * spring, 1))
	global_transform.basis = Basis(actual)

func _input(event):
	if event.get_class() == "InputEventMouseMotion":
		rotation_degrees.x -= -event.relative.y / pan
		rotation_degrees.y -= event.relative.x / pan
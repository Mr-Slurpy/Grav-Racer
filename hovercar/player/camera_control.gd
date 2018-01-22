extends Spatial

const pan = 8
const spring = 0.8

onready var hovercar = $"../Hovercar"

var pitch = 0
var yaw = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	var desired = Quat(hovercar.global_transform.basis)
	var current = Quat(global_transform.basis)
	var actual = current.slerp(desired, min(delta * spring, 1))
	transform.basis = Basis(actual)

func _input(event):
	if event.get_class() == "InputEventMouseMotion":
		rotation_degrees.x -= -event.relative.y / pan
		rotation_degrees.y -= event.relative.x / pan
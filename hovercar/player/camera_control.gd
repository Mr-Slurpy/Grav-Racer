extends Spatial

const pan = 12
const spring = 3.5
const max_distort = 90

onready var hovercar = get_node("../Hovercar")
onready var camera = get_node("Camera")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	transform.origin = hovercar.transform.origin
	
	var desired = Quat(hovercar.global_transform.basis)
	var current = Quat(global_transform.basis)
	var actual = current.slerp(desired, min(delta * spring, 1))
	global_transform.basis = Basis(actual)
	
	camera.fov = range_lerp(min(hovercar.speed(), max_distort), 0, max_distort, 100, 145)

func _input(event):
	if event is InputEventMouseMotion:
		transform.basis = transform.basis.rotated(transform.basis.y, deg2rad(-event.relative.x / pan))
		transform.basis = transform.basis.rotated(transform.basis.x, deg2rad(event.relative.y / pan))
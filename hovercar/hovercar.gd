extends KinematicBody

const level = 4
const grav_strength = 10
const rot_strength = 10

onready var front_left = $FrontLeft
onready var front_right = $FrontRight
onready var back_left = $BackLeft
onready var back_right = $BackRight

var linear_velocity = Vector3()

func _ready():
	pass

func _process(delta):
	pass

func _physics_process(delta):
	var colliding = 0
	var mean_normal = Vector3()
	var mean_collision = Vector3()
	if front_left.is_colliding():
		mean_normal += front_left.get_collision_normal()
		mean_collision += front_left.get_collision_point()
		colliding += 1
	if front_right.is_colliding():
		mean_normal += front_right.get_collision_normal()
		mean_collision += front_right.get_collision_point()
		colliding += 1
	if back_left.is_colliding():
		mean_normal += back_left.get_collision_normal()
		mean_collision += back_left.get_collision_point()
		colliding += 1
	if back_right.is_colliding():
		mean_normal += back_right.get_collision_normal()
		mean_collision += back_right.get_collision_point()
		colliding += 1
	
	if colliding != 0:
		mean_normal = mean_normal.normalized()
		mean_collision /= colliding
		
		var desired = global_transform.basis
		var x = desired.x
		var y = mean_normal
		var z = desired.z
		y = mean_normal
		x = x - y * y.dot(x)
		x = x.normalized()
		z = z - y * y.dot(z) - x * x.dot(z)
		z = z.normalized()
		desired.x = x
		desired.y = y
		desired.z = z
		desired = Quat(desired)
		var current = Quat(global_transform.basis)
		var actual = current.slerp(desired, min(delta * rot_strength, 1))
		global_transform.basis = Basis(actual)
		
		var height = global_transform.origin.distance_to(mean_collision) - level + 1
		var local_velocity = global_transform.basis.xform_inv(linear_velocity)
		local_velocity.x /= 1.2
		local_velocity.y = -height * grav_strength
		linear_velocity = global_transform.basis.xform(local_velocity)
	
	linear_velocity = move_and_slide(linear_velocity, mean_normal)

func turn(amount):
	global_transform.basis = global_transform.basis.rotated(global_transform.basis.y.normalized(), amount)

func move(vel):
	var local_velocity = global_transform.basis.xform_inv(linear_velocity)
	local_velocity += vel
	linear_velocity = global_transform.basis.xform(local_velocity)
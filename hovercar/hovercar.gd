extends RigidBody

const level = 4
const grav_strength = 10
const rot_strength = 16

onready var gravity = get_node("Gravity")

func _ready():
	pass

func _process(delta):
	pass

func _physics_process(delta):
	pass

func _integrate_forces(state):
	if gravity.is_colliding():
		var normal = gravity.get_collision_normal()
		var rot_z = normal.angle_to(global_transform.basis.x) - PI / 2
		var rot_x = normal.angle_to(global_transform.basis.z) - PI / 2
		rot_z = tan(rot_z / 2) * rot_strength
		rot_x = -tan(rot_x / 2) * rot_strength
		state.set_angular_velocity(Vector3(rot_x, state.get_angular_velocity().y / 1.2, rot_z))
		
		var height = gravity.global_transform.origin.distance_to(gravity.get_collision_point()) - level
		var local_velocity = global_transform.basis.xform_inv(state.get_linear_velocity())
		local_velocity.x /= 1.2
		local_velocity.y = -height * grav_strength
		if Input.is_action_pressed("drive"):
			local_velocity.z += 0.2
		state.set_linear_velocity(global_transform.basis.xform(local_velocity))
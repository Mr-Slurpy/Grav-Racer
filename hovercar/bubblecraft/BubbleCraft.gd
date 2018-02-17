extends Spatial

const max_pitch = 100;

onready var hovercar = get_parent();

func _ready():
	pass

func _physics_process(delta):
	var effect = AudioServer.get_bus_effect(1, 0)
	effect.pitch_scale = range_lerp(min(hovercar.speed(), max_pitch), 0, max_pitch, 0.85, 2.0);
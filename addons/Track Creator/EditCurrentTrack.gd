extends LineEdit

var last = ""

func _ready():
	connect("text_entered", self, "commit")
	connect("focus_exited", self, "unfocused")

func unfocused():
	text = last

func commit(new_text):
	last = new_text
	get_parent().set_current_track(new_text)
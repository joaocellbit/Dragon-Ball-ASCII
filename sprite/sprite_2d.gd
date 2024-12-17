extends Sprite2D

@onready var mundo = $"../Mundo_proc"
@onready var cam =$Camera2D
var zoom = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var numr = randi_range(1,100)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_J) and zoom == false:
		cam.zoom.x = 0.15
		cam.zoom.y = 0.15
	else:
		cam.zoom.x = 1
		cam.zoom.y = 1

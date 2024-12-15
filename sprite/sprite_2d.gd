extends Sprite2D

@onready var mundo = $"../Mundo_proc"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var numr = randi_range(1,100)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

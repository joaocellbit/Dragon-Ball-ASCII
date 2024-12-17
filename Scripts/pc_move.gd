extends Node2D
var pc
var rounds = Global.Rodadas
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pc = get_node("../PC")
	print(pc.name)
	print(rounds)

	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right"):
		Global.Rodadas += 1
		print(Global.Rodadas)
		var axi = Input.get_axis("ui_left", "ui_right")
		pc.position.x += axi*16
	elif event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down"):
		Global.Rodadas += 1
		print(Global.Rodadas)
		var axiy = Input.get_axis("ui_up", "ui_down")
		pc.position.y += axiy*16

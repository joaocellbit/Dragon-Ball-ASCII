extends Node2D

@export var noise_height: NoiseTexture2D
@export var noise: Noise
var width = 500
var height = 500
var noise_val_array = []
@onready var grass = $grass
@onready var water = $water
@onready var sand = $sand
@onready var hill = $montanha

var source_id = 0
var water_atlas = Vector2i(14,11)
var land_atlas = Vector2i(9,19)
var sand_atlas = Vector2i(12,3)
var hill_atlas = Vector2i(14,2)
var seed
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	noise_height.noise.set_seed(randi())
	seed = noise_height.noise.get_seed()
	print("seed: ", noise_height.noise.get_seed())
	noise = noise_height.noise 
	generate_world()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func generate_world():
	for x in range(-width/2,width/2):
		for y in range(-height/2, height/2):
			var noise_val: float = noise.get_noise_2d(x,y)
			if noise_val >= 0.08 and noise_val <0.45:
				grass.modulate = Color(0.133, 0.545, 0.133, 1)
				grass.set_cell(Vector2(x,y),source_id,land_atlas)
				#terra
		
			elif noise_val < 0.0:
				water.modulate = Color(0, 0, 0.5, 1)
				water.set_cell(Vector2(x,y),source_id,water_atlas)
				#agua
			elif noise_val >= 0.0 and noise_val<0.08:
				sand.modulate = Color(0.761, 0.698, 0.502, 1)
				sand.set_cell(Vector2(x,y), source_id, sand_atlas)
				#areia
			else:
				hill.modulate = Color(0.545, 0.271, 0.075, 1)
				hill.set_cell(Vector2(x,y), source_id, hill_atlas)
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_K):
		noise_height.noise.frequency = 0.006
		var PC = $"../PC"
		print(PC.position)
		var cordsx= PC.position.x/5
		var cordsy= PC.position.y/5
		var newoff = Vector3(cordsx,cordsy,0)
		print(cordsx,cordsy)
		print(newoff)
		noise_height.noise.offset = newoff
		grass.clear()
		water.clear()
		sand.clear()
		hill.clear()
		generate_world()
		
	 

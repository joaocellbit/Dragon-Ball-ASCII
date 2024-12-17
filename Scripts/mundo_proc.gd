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
@onready var ice = $ice

var source_id = 0
var water_atlas = Vector2i(14,11)
var land_atlas = Vector2i(9,19)
var sand_atlas = Vector2i(12,3)
var hill_atlas = Vector2i(14,2)
var ice_atlas = Vector2i(2,17)
var seed
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	noise_height.noise.set_seed(randi())
	seed = noise_height.noise.get_seed()
	print("seed: ", noise_height.noise.get_seed())
	noise = noise_height.noise 
	var dice1 = randi_range(-1,1)
	var dice2 = randi_range(-1,1)
	var dice3 = randi_range(-1,1)
	var dice4 = randi_range(-1,1)
	var result = dice1+dice2+dice3+dice4
	if result == 4:
		print("KOKUSEN")
	print(result)
	generate_world()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func generate_world():
	for x in range(-width/2,width/2):
		for y in range(-height/2, height/2):
			var snowper = randf_range(0.01, 0.1)
			var noise_val: float = noise.get_noise_2d(x,y)
			if x%2 == 0 and y%2==0:
				if noise_val >= 0.08 and noise_val <0.45 and y > (-1)*(height/2 - height*snowper) and y < height/2 - height*snowper:
					grass.modulate = Color(0.133, 0.545, 0.133, 1)
					grass.set_cell(Vector2(x,y),source_id,land_atlas)
					#terra
			
				elif noise_val < 0.0 and y  > (-1)*(height/2 - height*snowper) and y < height/2 - height*snowper:
					water.modulate = Color(0, 0, 0.5, 1)
					water.set_cell(Vector2(x,y),source_id,water_atlas)
					#agua
				elif noise_val >= 0.0 and noise_val<0.08 and y > (-1)*(height/2 - height*snowper) and y < height/2 - height*snowper :
					sand.modulate = Color(0.761, 0.698, 0.502, 1)
					sand.set_cell(Vector2(x,y), source_id, sand_atlas)
					#areia
				elif noise_val >=0.45 and y > (-1)*(height/2 - height*snowper) and y < height/2 - height*snowper:
					hill.modulate = Color(0.545, 0.271, 0.075, 1)
					hill.set_cell(Vector2(x,y), source_id, hill_atlas)
				else:
					ice.set_cell(Vector2(x,y), source_id, ice_atlas)
			else:
				pass
func generate_world_zoom():
	width = height
	ice.scale = Vector2(1,1)
	grass.scale = Vector2(1,1)
	water.scale = Vector2(1,1)
	hill.scale = Vector2(1,1)
	sand.scale = Vector2(1,1)
	for x in range(-width/2,width/2):
		for y in range(-height/2, height/2):
			var snowper = randf_range(0.01, 0.1)
			var noise_val: float = noise.get_noise_2d(x,y)
			if noise_val >= 0.02 and noise_val <0.45:
				grass.modulate = Color(0.133, 0.545, 0.133, 1)
				grass.set_cell(Vector2(x,y),source_id,land_atlas)
				#terra
		
			elif noise_val < 0.0:
				water.modulate = Color(0, 0, 0.5, 1)
				water.set_cell(Vector2(x,y),source_id,water_atlas)
				#agua
			elif noise_val >= 0.0 and noise_val<0.02:
				sand.modulate = Color(0.761, 0.698, 0.502, 1)
				sand.set_cell(Vector2(x,y), source_id, sand_atlas)
				#areia
			elif noise_val >=0.45:
				hill.modulate = Color(0.545, 0.271, 0.075, 1)
				hill.set_cell(Vector2(x,y), source_id, hill_atlas)
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		var mousepos = get_global_mouse_position()
		var tileselec = grass.local_to_map(mousepos)
		var tileselec2 = grass.map_to_local(mousepos)
		
		noise_height.noise.frequency = 0.0015
		var newoff = Vector3(tileselec.x,tileselec.y,0)
		print("new off: ",tileselec)
		noise_height.noise.offset = newoff
		grass.clear()
		water.clear()
		sand.clear()
		hill.clear()
		ice.clear()
		generate_world_zoom()
		print("tile selecionado: ", tileselec, tileselec2)

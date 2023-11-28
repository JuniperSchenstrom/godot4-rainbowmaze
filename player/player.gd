extends Node2D

const initial_position: Vector2 = Vector2(64, 64)
const initial_scale:float = 1
const initial_rotation_degrees:float = -90
const speed: Vector2 = Vector2(200, 200)
var direction: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	
	position = initial_position
#	scale = Vector2(initial_scale, initial_scale)
	rotation_degrees = initial_rotation_degrees

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	position += direction * speed * delta

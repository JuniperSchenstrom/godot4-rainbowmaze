extends CharacterBody2D

const initial_rotation_degrees:float = -90
const speed: Vector2 = Vector2(120, 120)
var direction: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	
	rotation_degrees = initial_rotation_degrees

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	# keyboard input for player movement
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()

func player_tile_enter():
	# used by tile to check if the body entering is the player
	pass

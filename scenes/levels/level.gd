extends Node2D

# !!UPDATE THIS IF THE NUMBER OF TILES IN THE MAZE CHANGES!! 
const level_tile_count: int = 510
# !!^^^!!

# Called when the node enters the scene tree for the first time.
func _ready():
	
	GlobalVariables.has_visited_count = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if GlobalVariables.has_visited_count >= level_tile_count:
		$WinText.show()

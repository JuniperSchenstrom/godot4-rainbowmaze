extends Node2D

#var tile_map: 

# Called when the node enters the scene tree for the first time.
func _ready():
	
#	generate($MazeTiles)
#	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	pass

# code from https://www.reddit.com/r/godot/comments/uakvk2/simple_tilemap_random_maze_generation_example/

# "export" was at the start of these lines
var width := 5 #setget set_width
var height := 5 #setget set_height

func generate(tile_map: TileMap):
	var visited : Array
	var search_stack : Array
	var connections = {}
	
	var all_points = []
	for i in range(width * height):
		var x = i % width
		var y = floor(i / height)
		var point = Vector2(x, y)
		
		all_points.push_back(point)
		
		# We'll be using a bitmask to track connections to neighboring cells.
		# Conventiently we can then use this same number as the index to the
		# correct tile in the tiletilemap when settings tiles. To begin there
		# are no connections.
		connections[point] = 0b0000
		
	var start = all_points[randi() % all_points.size()]
	search_stack = [start]
	visited = [start]
	
	while search_stack.size() > 0:
		# The current cell is the top of the search stack, but we want to leave
		# it on the stack since we may backtrack to it and end up checking the
		# rest of its neighbors, if we haven't already visited them.
		var current = search_stack[0]
		var valid_neighbors = _get_valid_neighbors(current)
		var unvisited_neighbors = []

		# If any neighbors of the current cell have already been visited we're
		# not interested in them.
		for neighbor in valid_neighbors:
			if not visited.has(neighbor):
				unvisited_neighbors.push_front(neighbor)

		if unvisited_neighbors.size() > 0:
			# We haven't yet visited all neighbors of the current cell, so we'll
			# randomly pick one to visit next
			var next = unvisited_neighbors[randi() % unvisited_neighbors.size()]
			
			# Update the connections for the current cell. Get the relative direction
			# from current to next
			var current_connections = connections[current]
			connections[current] = _set_connection(current_connections, next - current)
			
			# Update the connections for the next cell. Get the relative direction
			# from next to current
			var next_connections = connections[next]
			connections[next] = _set_connection(next_connections, current - next)
			
			# Mark the next cell as visited and add it to the top of the search
			# stack so we can check its neighbors next iteration
			visited.push_front(next)
			search_stack.push_front(next)
		else:
			# We've already visited all neighbors, so backtrack
			search_stack.pop_front()
	
	# We've visited every cell and emptied the search stack
	for point in all_points:
		# Use the connections bitmask for the current point as the tileset index
		# and set the cell.
		var conns = connections[point]
		tile_map.set_cellv(point, conns)

func _get_valid_neighbors(tile: Vector2) -> Array:
	var candidates = [
		tile + Vector2.UP,
		tile + Vector2.DOWN,
		tile + Vector2.RIGHT,
		tile + Vector2.LEFT
	]
	var neighbors = []
	
	for candidate in candidates:
		if (candidate.x < 0
			or candidate.x >= width
			or candidate.y < 0
			or candidate.y >= height):
			continue
		
		neighbors.push_back(candidate)
	return neighbors
	
func _set_connection(connection_bits, target):
	match target:
		# 1 = connection
		# 0 = no connection
		#   NSEW
		# 0b1111
		#
		# Check which direction we're connecting and set the corresponding bit
		Vector2.UP:
			return connection_bits | 0b1000
		Vector2.DOWN:
			return connection_bits | 0b0100
		Vector2.RIGHT:
			return connection_bits | 0b0010
		Vector2.LEFT:
			return connection_bits | 0b0001

func set_width(value):
	width = int(max(5, value))
	
func set_height(value):
	height = int(max(5, value))

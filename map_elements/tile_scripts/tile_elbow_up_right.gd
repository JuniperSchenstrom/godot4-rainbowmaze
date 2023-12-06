extends StaticBody2D

var has_been_visited: bool = false

func _on_area_2d_body_entered(body):
	
	if body.has_method("player_tile_enter"):# check for if the body entering is the player
		
		# switch sprites when player enters
		$Sprite2D.hide()
		$Sprite2D_C.show()
		
		if !has_been_visited:
			
			GlobalVariables.has_visited_count += 1
			
			has_been_visited = true

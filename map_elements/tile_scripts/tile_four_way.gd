extends StaticBody2D

func _on_area_2d_body_entered(body):
	
	if body.has_method("player_tile_enter"):# check for if the body entering is the player
		
		# switch sprites when player enters
		$Sprite2D.hide()
		# add color sprite
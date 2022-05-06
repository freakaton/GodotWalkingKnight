extends Sprite


export(String, FILE) var game_scene = ""
var game_instance
var player

func _on_Area2D_area_entered(area):
	if area.get_name() == "PlayerArea":
		player = area.get_parent()
		game_instance = load(game_scene).instance()
		game_instance.connect("win_game", self, "_on_game_exited")
		game_instance.connect("exit_game", self, "_on_game_exited")
		player.set_physics_process(false)
		get_parent().add_child(game_instance)


func _on_game_exited():
	player.set_physics_process(true)
	game_instance.queue_free()

func _on_Area2D_area_exited(area):
	pass
#	get_node(NodePath('/root/SceneManager/DialogBox')).hide_text()

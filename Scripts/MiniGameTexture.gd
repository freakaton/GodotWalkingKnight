extends "res://Scripts/SpeakTexture.gd"

export(String, FILE) var game_scene = ""
onready var loaded_game_scene = load(game_scene)

func _ready():
	assert(game_scene != "", "ERROR: You must provide game_scene variable")


func _input(event):
	if Input.is_action_pressed("ui_accept"):
		var is_player_overlaps = false
		for area in $Area2D.get_overlapping_areas():
			if area.get_name() == "PlayerArea":
				is_player_overlaps = true
		if is_player_overlaps:
			var scene_manager = get_node(NodePath('/root/SceneManager/'))
			scene_manager.transition_to_game(loaded_game_scene.instance())
			_on_Area2D_area_exited(null)

func _on_Area2D_area_exited(area):
	get_node(NodePath('/root/SceneManager/DialogBox')).hide_text()

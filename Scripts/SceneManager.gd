extends Node2D

var next_scene = null
var spawn_teleport = null
onready var player = load('res://Scenes/Player.tscn').instance()



func _ready():
	
	$CurrentScene/Map_0.spawn_player(
		player, $CurrentScene/Map_0/Teleport_0/SpawnPoint
	)
	$AnimationPlayer.play("FadeToNormal")


func transition_to_fading(new_scene: String, teleport: String):
	next_scene = new_scene
	spawn_teleport = teleport
	$AnimationPlayer.play("FadeToBlack")


func transition_finished():
	player.get_parent().remove_child(player)
	$CurrentScene.get_child(0).queue_free()
	var instance = load(next_scene).instance()
	var spawn_point = instance.get_node(
		NodePath(spawn_teleport + '/SpawnPoint')
	)
	$CurrentScene.add_child(instance)
	instance.spawn_player(player, spawn_point)
	$AnimationPlayer.play("FadeToNormal")

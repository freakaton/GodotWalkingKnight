extends Node2D

var spawn_point = null

func _ready():
	pass
#	if spawn_point == null:
#		spawn_point = get_node("Teleport_0/SpawnPoint")
#	var p = spawn_point.position
#	$Player.start(p)

func spawn_player(player, spawn_point):
	add_child(player)
	player.start(spawn_point.global_position)

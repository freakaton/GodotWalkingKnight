extends Area2D

export(String, FILE) var scene_name = ""
export(String) var spawn_point = ""



func _ready():
	assert(scene_name != "", "ERROR: You must provide scene_name variable")


func teleport_entered(area_rid, area, area_shape_index, local_shape_index):
	print(area.get_name(), " entered teleport")
	if area.get_name() == "PlayerArea":
		var scene_manager = get_node(NodePath('/root/SceneManager/'))
		scene_manager.transition_to_fading(scene_name, name)

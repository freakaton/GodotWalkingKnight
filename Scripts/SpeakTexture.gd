extends Sprite


export(String, MULTILINE) var text = ""


func _on_Area2D_area_entered(area):
	if area.get_name() == "PlayerArea":
		get_node(NodePath('/root/SceneManager/DialogBox')).show_text(text)


func _on_Area2D_area_exited(area):
	get_node(NodePath('/root/SceneManager/DialogBox')).hide_text()

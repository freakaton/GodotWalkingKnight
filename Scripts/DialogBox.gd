extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func show_text(text: String):
	$CanvasLayer/PopupDialog/Label.text = text
	$CanvasLayer/PopupDialog.popup()
	
	
func hide_text():
	$CanvasLayer/PopupDialog.hide()

extends CanvasLayer


func _ready():
	randomize()
	$BaseLevel.start_game()


func _on_game_over():
	$RefreshTimer.stop()
	$EndGamePanel.show()


func _on_level_finished():
	$RefreshTimer.stop()
	yield(get_tree().create_timer(1), "timeout")
	$BaseLevel.clean_arena()
	$FinishGamePanel.show()

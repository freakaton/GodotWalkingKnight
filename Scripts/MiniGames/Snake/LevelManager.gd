extends CanvasLayer

signal win_game
signal exit_game


var current_level = 1
var level_instance
var levels = [
	load('res://Scenes/MiniGames/Snake/Level_1.tscn'),
	load('res://Scenes/MiniGames/Snake/Level_2.tscn')
]


func _ready():
	randomize()
	start_level()


func start_level():
	if level_instance:	
		level_instance.queue_free()

	$InfoPanel/Level.text = str(current_level)
	level_instance = levels[current_level - 1].instance()
	$LevelContainer.add_child(level_instance)
	$LevelContainer/RefreshTimer.connect("timeout", level_instance, "update")
	level_instance.connect("game_over", self, "_on_game_over")
	level_instance.connect("level_finished", self, "_on_level_finished")
	level_instance.start_game()
	$LevelContainer/RefreshTimer.start()


func _on_game_over():
	$LevelContainer/RefreshTimer.stop()
	$EndGamePanel.show()


func _on_level_finished():
	$LevelContainer/RefreshTimer.stop()
	yield(get_tree().create_timer(1), "timeout")
	level_instance.clean_arena()
	current_level += 1
	if current_level > len(levels):
		$WinGamePanel.show()
	else:
		$FinishGamePanel.show()


func _on_win():
	emit_signal("win_game")

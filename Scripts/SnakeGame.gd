extends Panel

signal end_game


const BORDER = -1
const SNAKE = 0
const BERRY = 1
const CLEAR = 4

const CELL_SIZE = 8
enum MOVE {UP, DOWN, LEFT, RIGHT}

var direction = MOVE.DOWN
var moved = true
var arena_size = Vector2()
var score = 0
onready var score_label = get_node("../InfoPanel/Score")


var snake = [
	[1, 5],
	[1, 4],
	[1, 3],
	[1, 2],
	[1, 1]
]


func _ready():
	randomize()
	# print(generate_berry())
	var rect = get_rect()
	arena_size = (rect.size / 8).floor()
	
	print(arena_size)	
	for cell in snake:	
		$SnakeApple.set_cell(
			cell[0], cell[1], SNAKE, false, false, false, Vector2(4,0)
			)

func _input(event):
	if not moved:
		return

	var old_direction = direction
	if Input.is_action_pressed("ui_right") and direction != MOVE.LEFT:
		direction = MOVE.RIGHT
	elif Input.is_action_pressed("ui_left") and direction != MOVE.RIGHT:
		direction = MOVE.LEFT
	elif Input.is_action_pressed("ui_down") and direction != MOVE.UP:
		direction = MOVE.DOWN
	elif Input.is_action_pressed("ui_up") and direction != MOVE.DOWN:
		direction = MOVE.UP

	if old_direction != direction:
		moved = false

func next_cell(last_cell):
	var ret = [last_cell[0], last_cell[1]]
	match direction:
		MOVE.RIGHT:
			ret[0] += 1
		MOVE.LEFT:
			ret[0] -= 1
		MOVE.UP:
			ret[1] -= 1
		MOVE.DOWN:
			ret[1] += 1
	return ret

func _on_RefreshTimer_timeout():
	var cell_to_clear = snake.pop_back()
	var next_cell = next_cell(snake[0])
	snake.push_front(next_cell)
	# print(snake)
	match $SnakeApple.get_cell(next_cell[0], next_cell[1]):
		BORDER, SNAKE:
			emit_signal("end_game")
		BERRY:
			score += 1
			score_label.text = str(score)
			generate_berry()
			
		
	$SnakeApple.set_cell(cell_to_clear[0], cell_to_clear[1], CLEAR)
	$SnakeApple.set_cell(
		next_cell[0], next_cell[1], SNAKE, false, false, false, Vector2(4,0)
	)
	score += 1
	score_label.text = str(score)
	moved = true

func generate_berry():
		while true:
			var x = randi()# % int(arena_size.x - 1)
			var y = randi()# % int(arena_size.y - 1)
			for i in snake:
				if x == i[0] and y == i[1]:
					continue
			$SnakeApple.set_cell(
				x, y, BERRY, false, false, false, Vector2(4,0)
			)
			return
			
		 
func _on_Panel_end_game():
	$RefreshTimer.stop()
	$DeadLabel.show()

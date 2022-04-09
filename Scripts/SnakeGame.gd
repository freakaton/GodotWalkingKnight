extends Node


const SNAKE = 0
const BERRY = 1
const CLEAR = -1
enum MOVE {UP, DOWN, LEFT, RIGHT}

var direction = MOVE.DOWN
var snake = [
	[1, 5],
	[1, 4],
	[1, 3],
	[1, 2],
	[1, 1]
]

func _ready():
	for cell in snake:	
		$SnakeApple.set_cell(
			cell[0], cell[1], SNAKE, false, false, false, Vector2(4,0)
			)

func _input(event):
	if Input.is_action_pressed("ui_right") and direction != MOVE.LEFT:
		direction = MOVE.RIGHT
	if Input.is_action_pressed("ui_left") and direction != MOVE.RIGHT:
		direction = MOVE.LEFT
	if Input.is_action_pressed("ui_down") and direction != MOVE.UP:
		direction = MOVE.DOWN
	if Input.is_action_pressed("ui_up") and direction != MOVE.DOWN:
		direction = MOVE.UP

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
	print(snake)
	$SnakeApple.set_cell(cell_to_clear[0], cell_to_clear[1], CLEAR)
	$SnakeApple.set_cell(
		next_cell[0], next_cell[1], SNAKE, false, false, false, Vector2(4,0)
	)

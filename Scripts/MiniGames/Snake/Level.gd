extends Panel

signal game_over
signal level_finished


const BORDER = 5
const SNAKE = 0
const BERRY = 1
const CLEAR = -1

const CELL_SIZE = 8
enum MOVE {UP, DOWN, LEFT, RIGHT}

var direction = MOVE.DOWN
var moved = true
var arena_size = Vector2()
var score = 0
var snake = []
var current_berry
onready var score_label = get_node("../../InfoPanel/Score")

var START_POSITION = [
	Vector2(1, 5),
	Vector2(1, 4),
	Vector2(1, 3),
	Vector2(1, 2),
	Vector2(1, 1)
]
export var score_to_finish = 5


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

func get_next_cell(last_cell: Vector2) -> Vector2:
	var ret = Vector2(last_cell.x, last_cell.y)
	match direction:
		MOVE.RIGHT:
			ret.x += 1
		MOVE.LEFT:
			ret.x -= 1
		MOVE.UP:
			ret.y -= 1
		MOVE.DOWN:
			ret.y += 1
	return ret

func update():
	# print(snake)
	var next_cell = get_next_cell(snake[0])
	match $SnakeApple.get_cell(next_cell.x, next_cell.y):
		BORDER, SNAKE:
			emit_signal("game_over")
			return
		BERRY:
			add_score(3)
			current_berry = null

	var cell_to_clear = snake.pop_back()	
	snake.push_front(next_cell)
	$SnakeApple.set_cell(cell_to_clear.x, cell_to_clear.y, CLEAR)
	$SnakeApple.set_cell(
		next_cell.x, next_cell.y, SNAKE, false, false, false, Vector2(4,0)
	)
	moved = true
	if score >= score_to_finish:
		emit_signal("level_finished")
		return
	if not current_berry:
		current_berry = generate_berry()

func add_score(points: int):
	score += points
	score_label.text = str(score)
	
func generate_berry() -> Vector2:
	var x = 0
	var y = 0
	while true:
		x = randi() % int(arena_size.x - 1)
		y = randi() % int(arena_size.y - 1)
		var cell = $SnakeApple.get_cell(x, y)
		if cell != CLEAR:
			continue
		$SnakeApple.set_cell(
			x, y, BERRY, false, false, false, Vector2(4,0)
		)
		break
	return Vector2(x, y)

func start_game():
	clean_arena()
	snake = START_POSITION.duplicate()
	for cell in snake:	
		$SnakeApple.set_cell(
			cell.x, cell.y, SNAKE, false, false, false, Vector2(4,0)
		)
	current_berry = generate_berry()
	$'../../EndGamePanel'.hide()
	$'../../FinishGamePanel'.hide()

func clean_arena():
	var rect = get_rect()
	arena_size = (rect.size / 8).floor()
	for cell in snake:	
		$SnakeApple.set_cell(
			cell.x, cell.y, CLEAR, false, false, false, Vector2(4,0)
		)
	if current_berry:
		$SnakeApple.set_cell(
			current_berry.x, current_berry.y, CLEAR, false, false, false, Vector2(4,0)
		)
	direction = MOVE.DOWN
	score = 0
	score_label.text = str(score)

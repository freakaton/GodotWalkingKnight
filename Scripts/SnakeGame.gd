extends Node


const SNAKE = 0
const BERRY = 1


var snake = [
	[1, 1],
	[1, 2],
	[1, 3],
	[1, 4],
	[1, 5],
]

func _ready():
	for cell in snake:	
		$SnakeApple.set_cell(
			cell[0], cell[1], SNAKE, false, false, false, Vector2(4,0)
			)

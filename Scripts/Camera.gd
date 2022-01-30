extends Camera2D


onready var parent = $'..'

func _ready():
	limit_bottom = parent.MAP_SIZE * parent.MAP_CELL_SIZE
	limit_right = parent.MAP_SIZE * parent.MAP_CELL_SIZE
	limit_left = 0
	limit_top = 0
	

func _physics_process(delta):
	pass

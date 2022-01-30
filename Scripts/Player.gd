extends KinematicBody2D


signal player_entering_teleport

const DEFAULT_SPEED = 35
const PATH_SPEED = 70

# height and width of map part in cells
const MAP_SIZE = 30
const MAP_CELL_SIZE = 16


var speed = DEFAULT_SPEED
var look_direction = Vector2()


func start(pos):
	position = pos
	var v = visible
	show()
	# $CollisionShape2D.disabled = false


func _ready():
	hide()


func _physics_process(delta):
	var velocity = Vector2()  # The player's movement vector.
	# if position.distance_to(target) > 10:
	# 	velocity = target - position

	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		look_direction = velocity.normalized()
		velocity = velocity.normalized() * speed

	move_and_slide(velocity)
	# position += velocity
	position.x = clamp(position.x, 5, MAP_CELL_SIZE * MAP_SIZE - 5)
	position.y = clamp(position.y, 5, MAP_CELL_SIZE * MAP_SIZE - 5)

	if velocity.x != 0:
		$Sprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$Sprite.flip_h = false


func path_entered(body):
	print(body.get_name(), " entered")
	if body.get_name() == "Paths":
		speed = PATH_SPEED


func path_exited(body):
	print(body.get_name(), " exited")
	if body.get_name() == "Paths":
		speed = DEFAULT_SPEED


func teleport_entered(area_rid, area, area_shape_index, local_shape_index):
	print(area.get_name(), " entered")
	if area.get_name() == "Teleport":
		emit_signal("player_entering_teleport")
	


func _on_Player_tree_exiting():
	var m = position

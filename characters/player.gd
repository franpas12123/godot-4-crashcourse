extends CharacterBody2D

@export var SPEED = 150.0

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

@onready var starting_direction = Vector2(0, 1)

func _ready():
	update_animation_parameters(starting_direction)

func _physics_process(_delta):
	var input_direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))

	update_animation_parameters(input_direction)

	if input_direction.x:
		velocity.x = input_direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if input_direction.y:
		velocity.y = input_direction.y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	pick_state()


func update_animation_parameters(move_input : Vector2):
	if (move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)

func pick_state():
	print(velocity)
	if velocity == Vector2.ZERO:
		state_machine.travel("Idle")
	else:
		state_machine.travel("Walk")

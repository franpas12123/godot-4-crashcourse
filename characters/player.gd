extends CharacterBody2D

@export var SPEED = 150.0

func _physics_process(_delta):
	var directionx = Input.get_axis("left", "right")
	var directiony = Input.get_axis("up", "down")
	if directionx:
		velocity.x = directionx * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if directiony:
		velocity.y = directiony * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

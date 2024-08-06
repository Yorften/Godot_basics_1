extends CharacterBody2D


@export var SPEED = 100.0
@export var JUMP_VELOCITY = -250.0

@onready var animated_sprite = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	
	if is_on_floor():
			if direction == -1:
				animated_sprite.play('run')
				animated_sprite.flip_h = true
			elif direction == 1:
				animated_sprite.play('run')
				animated_sprite.flip_h = false
			elif direction == 0:
				animated_sprite.play('idle')
	else:
			animated_sprite.play('jump')


	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

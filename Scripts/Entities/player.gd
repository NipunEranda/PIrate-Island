extends CharacterBody2D
class_name Player

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D

@export var speed = 200.0
@export var jump_velocity = -300.0

var jumpCount = 0

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("left"):
		sprite.scale.x = abs(sprite.scale.x) * -1
		
	if Input.is_action_just_pressed("right"):
		sprite.scale.x = abs(sprite.scale.x)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = jump_velocity
		
	if Input.is_action_just_pressed("jump") and jumpCount < 2:
		velocity.y = jump_velocity
		jumpCount += 1
		
	if jumpCount == 2 && is_on_floor():
		jumpCount = 0

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	update_animation()
	move_and_slide()
	
func update_animation():
	if velocity.x != 0:
		animation.play("run")
	else:
		animation.play("idle")
		
	if velocity.y < 0:
		animation.play("jump")
		
	if velocity.y > 0:
		animation.play("fall")

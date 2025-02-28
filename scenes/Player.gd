extends CharacterBody2D

@export var gravity = 600.0
@export var walk_speed = 200
@export var jump_speed = -300
@export var dash_speed = 1000

var can_double_jump = true
var is_crouching = false
var can_dash = false
var on_dash_cooldown = false
var is_dashing = false
var dash_direction = true  #true for right and false for left

@onready var sprite = $Sprite2D
@onready var dash_timer = $DashCheck
@onready var dash_duration_timer = $DashDuration
@onready var dash_cooldown_timer = $DashCooldown


func _physics_process(delta: float) -> void:
	_crouch()

	if is_on_floor():
		can_double_jump = true

	velocity.y += delta * gravity

	if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		velocity.y = jump_speed

	if not is_on_floor() and can_double_jump and Input.is_action_just_pressed("ui_up"):
		velocity.y = 0.8 * jump_speed
		can_double_jump = false

	if Input.is_action_just_released("ui_right") and not on_dash_cooldown:
		dash_direction = true
		can_dash = true
		dash_timer.start()

	if Input.is_action_just_released("ui_left") and not on_dash_cooldown:
		dash_direction = false
		can_dash = true
		dash_timer.start()

	if Input.is_action_just_pressed("ui_right") and can_dash and dash_direction:
		velocity.x = dash_speed
		is_dashing = true
		can_dash = false
		dash_duration_timer.start()
		print("dash!")

	if Input.is_action_just_pressed("ui_left") and can_dash and not dash_direction:
		velocity.x = -dash_speed
		is_dashing = true
		can_dash = false
		dash_duration_timer.start()
		print("dash!")

	if Input.is_action_pressed("ui_left") and not is_dashing:
		sprite.flip_h = true
		velocity.x = -walk_speed
	elif Input.is_action_pressed("ui_right") and not is_dashing:
		sprite.flip_h = false
		velocity.x = walk_speed
	elif not is_dashing:
		velocity.x = 0

	move_and_slide()


func _crouch():
	if Input.is_action_just_pressed("crouch"):
		if is_crouching:
			walk_speed *= 2
			sprite.frame = 0
			is_crouching = false
		else:
			walk_speed *= 0.5
			sprite.frame = 3
			is_crouching = true


func _on_dash_timeout() -> void:
	can_dash = false
	print("timeout!")


func _on_dash_duration_timeout() -> void:
	on_dash_cooldown = true
	dash_cooldown_timer.start()
	is_dashing = false


func _on_dash_cooldown_timeout() -> void:
	on_dash_cooldown = false

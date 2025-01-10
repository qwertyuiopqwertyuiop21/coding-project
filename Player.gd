extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var pivot: Node2D = $pivot
@onready var sprite_2d: Sprite2D = $pivot/Sprite2D
@onready var bullet_spawn: Node2D = $pivot/Sprite2D/BulletSpawn
const BULLET = preload("res://bullet.tscn")
@onready var timer: Timer = $Timer

var can_shoot = true

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity = lerp(velocity, Vector2.ZERO, 0.25)
	pivot.look_at(get_global_mouse_position())

	move_and_slide()
	

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot") and can_shoot:
		var new_bullet = BULLET.instantiate()
		new_bullet.global_position = bullet_spawn.global_position
		new_bullet.rotation = pivot.rotation
		new_bullet.direction = Vector2.RIGHT.rotated(pivot.rotation).normalized()
		get_tree().root.add_child(new_bullet)
		can_shoot = false
		timer.start()


func _on_timer_timeout() -> void:
	can_shoot = true
	pass # Replace with function body.

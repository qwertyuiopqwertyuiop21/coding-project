extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var pivot: Node2D = $pivot
@onready var sprite_2d: Sprite2D = $pivot/Sprite2D
@onready var bullet_spawn: Node2D = $pivot/Sprite2D/BulletSpawn
const BULLET = preload("res://bullet.tscn")
@onready var timer: Timer = $Timer

var can_shoot = true
var health=100
var ammo=20
var magazine=15
var magazinemax=15

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
	if Input.is_action_pressed("shoot") and can_shoot and magazine > 0:
		var new_bullet = BULLET.instantiate()
		new_bullet.global_position = bullet_spawn.global_position
		new_bullet.rotation = pivot.rotation
		new_bullet.direction = Vector2.RIGHT.rotated(pivot.rotation).normalized()
		get_tree().root.add_child(new_bullet)
		can_shoot = false
		timer.start()
		magazine-=1
	$Control/hp.text=str(health)
	$Control/ammo.text=str(ammo)
	$Control/Magazine.text=str(magazine)
	if Input.is_action_just_pressed("reload") and ammo > 0:
		ammo-=min((magazinemax-magazine),ammo)
		magazine=magazinemax
	
const BLOOD = preload("res://blood.tscn")

func _on_timer_timeout() -> void:
	can_shoot = true
	pass # Replace with function body.
func take_damage(amount):
	health-=amount
	if health <= 0:
		var blood=BLOOD.instantiate()
		get_tree().root.add_child(blood)
		blood.position=self.position
		blood.emitting=true
		queue_free()

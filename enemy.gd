extends CharacterBody2D
class_name Enemy
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var pivot: Node2D = $pivot
const BULLET = preload("res://bullet.tscn")
const BLOOD = preload("res://blood.tscn")
var life = 4
var target = null
const SPEED = 100.0
var canshoot=true 

func _physics_process(delta: float) -> void:
	if $"../Player":
		navigation_agent_2d.target_position = $"../Player".global_position
		var next_position = navigation_agent_2d.get_next_path_position()
		velocity = global_position.direction_to(next_position) * SPEED
		#pivot.look_at(global_position + velocity)
		#rotation = lerpf(rotation, velocity.angle() , 0.1)
		if navigation_agent_2d.is_navigation_finished():
			print("there")
			return
	
	move_and_slide()
	if target != null and canshoot:#we have a target
		canshoot=false
		$Timer.start()
		look_at(target.position)
		var bullet=BULLET.instantiate()
		bullet.isenemyshot=true
		bullet.direction = Vector2.RIGHT.rotated(rotation).normalized()
		get_tree().root.add_child(bullet)
		bullet.position=position
		bullet.rotation=rotation
	else:
		rotation = lerpf(rotation, velocity.angle() , 0.1)
func take_damage(amount:int):
	life -= amount
	
	if life <= 0:
		var blood=BLOOD.instantiate()
		get_tree().root.add_child(blood)
		blood.position=self.position
		blood.emitting=true
		queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		target=body
		print("player", body)


func _on_timer_timeout() -> void:
	canshoot=true
	pass # Replace with function body.

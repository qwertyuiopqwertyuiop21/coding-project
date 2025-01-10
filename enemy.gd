extends CharacterBody2D
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var pivot: Node2D = $pivot

var life = 4

const SPEED = 100.0


func _physics_process(delta: float) -> void:
	navigation_agent_2d.target_position = $"../Player".global_position
	var next_position = navigation_agent_2d.get_next_path_position()
	velocity = global_position.direction_to(next_position) * SPEED
	#pivot.look_at(global_position + velocity)
	rotation = lerpf(rotation, velocity.angle() , 0.1)
	if navigation_agent_2d.is_navigation_finished():
		print("there")
		return
	
	move_and_slide()
	
func take_damage(amount:int):
	life -= amount
	if life <= 0:
		queue_free()

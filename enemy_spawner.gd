extends Node2D
const ENEMY = preload("res://enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var new_enemy = ENEMY.instantiate()
	new_enemy.global_position = global_position
	get_parent().add_child(new_enemy)
	pass # Replace with function body.

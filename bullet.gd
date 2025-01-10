extends CharacterBody2D

var direction : Vector2 = Vector2(0,0)
var SPEED := 1000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity = direction * SPEED * delta
	var collisions = move_and_collide(velocity)
	if collisions:
		var collider = collisions.get_collider()
		var cell_rid = collisions.get_collider_rid()

		if collider is TileMapLayer:
			var cell_coord = collider.get_coords_for_body_rid(cell_rid)
			var cell_data = collider.get_cell_tile_data(cell_coord)
			if cell_data:
				print(cell_data.get_custom_data("test") )

			
		if collider.has_method("take_damage"):
			collider.take_damage(2)
		queue_free()
	

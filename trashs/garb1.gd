extends Area2D

@export var can_be_picked: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#try_pick_up()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Mia) -> void: 	
	if body.hasGarb:
		queue_free()

extends Area2D

@export var can_be_picked: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void: 
	can_be_picked = true
	#try_pick_up()

func try_pick_up() -> void:
	if can_be_picked and Input.is_action_just_pressed("pick_up"):
		#queue_free()
		print("Lixo coletado!")

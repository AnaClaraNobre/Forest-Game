extends CharacterBody2D
class_name BaseCharacter
@export_category("Variables")
@export var move_speed: float = 128.0

@export_category("Objects")
@export var animation: AnimationPlayer
func  _process(delta: float) -> void:
	pass
func _physics_process(_delta: float) -> void:
	var direction: Vector2 = Input.get_vector(
		"move_left", "move_right","move_up","move_down"
	)
	print(direction)
	velocity = direction * move_speed
	pass
	
	if velocity:
		animation.play()
		return
		animation.play("idle")

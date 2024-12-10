extends CharacterBody2D

var direction: Vector2
var wait_time: float
@export_category("Variables")
@export var _move_speed: float = 50.0
@export_category("Objects")
@export var sprit2d = AnimatedSprite2D
@onready var animation := $anim as AnimatedSprite2D
@export var walk_timer: Timer

func _ready() -> void:
	wait_time = randf_range(5.0, 15.0)
	direction = _get_direction()
	walk_timer.start(wait_time)

func _physics_process(delta: float) -> void:
	velocity = direction * _move_speed
	move_and_slide()
	if get_slide_collision_count() > 0:
		direction = velocity.bounce(
			get_slide_collision(0).get_normal()
		).normalized()
	_animate(velocity)

func _animate(_velocity: Vector2) -> void:
	if velocity == Vector2.ZERO:
		animation.play("idle")
		return

	if _velocity.x > 0:  
		sprit2d.flip_h = false  
		animation.play("walk")

	elif _velocity.x < 0:  
		sprit2d.flip_h = true  # Flip horizontal
		animation.play("walk")

func _get_direction() -> Vector2:
	return [
		Vector2(-1, 0), Vector2(1, 0),
		Vector2.ZERO
	].pick_random().normalized()

# Método que pode ser chamado para mover o cachorro para uma posição específica
func move_to_position(destination: Vector2) -> void:
	direction = (destination - position).normalized()  # Direção para o ponto de destino

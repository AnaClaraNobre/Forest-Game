extends CharacterBody2D
class_name cat

var direction: Vector2
var wait_time: float
@export_category("Variables")
@export var _move_speed: float = 50.0
@export_category("Objects")
@export var sprit2d = AnimatedSprite2D
@onready var animation := $anim as AnimatedSprite2D
@export var walk_timer: Timer

func _ready() -> void:
	wait_time = randf_range(5.0,15.0)
	direction = _get_direction()
	walk_timer.start(wait_time)
func _physics_process(delta: float) -> void:
	velocity = direction *_move_speed
	move_and_slide()
	if get_slide_collision_count()> 0:
		direction = velocity.bounce(
			get_slide_collision(0).get_normal()
		).normalized()
	_animate(velocity)
	
	
func _animate(_velocity : Vector2) -> void:
	if velocity == Vector2.ZERO:
		animation.play("idle")
		return
		
	if velocity.x > 0 and velocity.y == 0:
		sprit2d.flip_h = true  
		animation.play("walking_right")

	elif velocity.x < 0 and velocity.y == 0:
		sprit2d.flip_h = false  
		animation.play("walking_left")

	elif velocity.y > 0 and velocity.x == 0:
		animation.play("walking_down")
		
	elif velocity.y < 0 and velocity.x == 0:
		animation.play("walking_up")
		
	elif _velocity.x > 0 and _velocity.y > 0:  # Diagonal inferior direita
		sprit2d.flip_h = true
		animation.play("diag_down_rigth")
		
	elif _velocity.x < 0 and _velocity.y > 0:
		sprit2d.flip_h = false
		animation.play("diag_down_left")
	elif _velocity.x > 0 and _velocity.y < 0:
		sprit2d.flip_h = true
		animation.play("diag_up_rigth")
	elif _velocity.x < 0 and _velocity.y < 0:
		sprit2d.flip_h = false
		animation.play("diag_up_left")
		
func _get_direction() -> Vector2:
	return [
		Vector2(-1,0), Vector2(1,0), Vector2(-1,-1), Vector2(0,-1),
		Vector2(1,-1), Vector2(-1,1), Vector2(0,1), Vector2(1,1),
		Vector2.ZERO
	].pick_random().normalized()


func _on_walk_timer_timeout() -> void:
	walk_timer.start(wait_time)
	if direction == Vector2.ZERO:
		direction = _get_direction()
		return
	direction = Vector2.ZERO

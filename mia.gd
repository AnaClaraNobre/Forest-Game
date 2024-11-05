extends CharacterBody2D
class_name Mia

@export_category("Variables")
@export var move_speed: float = 128.0
@export var garbage_count: int = 0  # Quantidade de lixo coletado
@export var speed_reduction_per_garbage: float = 10.0  # Redução de velocidade por lixo coletado
@onready var pick_up_effect = $pick_up_effect as AudioStreamPlayer

# Armazena a velocidade original para restaurá-la depois
var original_move_speed: float = move_speed

@export_category("Objects")
@onready var animation := $anim as AnimatedSprite2D
@export var sprit2d = AnimatedSprite2D
var hasGarb: bool = false

var _can_pick: bool = true
var _pick_Up_animation_name: String = ""
@export var pick_up_name: String = ""

func _process(delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	_move()
	_pick()
	_animate()

func _move() -> void:
	var direction: Vector2 = Input.get_vector(
		"move_left", "move_right","move_up","move_down"
	)
	velocity = direction * move_speed
	move_and_slide()
	pass
	
func _pick() -> void: 
	if Input.is_action_just_pressed("pick_up") and _can_pick:
		_can_pick = false
		_pick_Up_animation_name = pick_up_name

	if Input.is_action_just_released("pick_up"):
		_can_pick = true
		set_physics_process(true)
		animation.play("side_idle")
		pick_up_effect.play()
		garbage_count += 1
		move_speed = max(0, move_speed - speed_reduction_per_garbage)
		
func _clearGarbage() -> void:
	garbage_count = 0
	move_speed = original_move_speed
		
func _animate() -> void:
	if velocity.x > 0 and velocity.y == 0:
		animation.play("side_walk")
		sprit2d.flip_h = true  

	elif velocity.x < 0 and velocity.y == 0:
		animation.play("side_walk")
		sprit2d.flip_h = false  

	if velocity.y > 0 and velocity.x == 0:
		animation.play("walk_down")
		
	if _can_pick == false:
		animation.play(_pick_Up_animation_name)
		return
		
	if velocity.y < 0 and velocity.x == 0:
		animation.play("up_walk")

	if velocity == Vector2.ZERO:
		animation.play("Down_idle")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == _pick_Up_animation_name:
		_can_pick = true
		set_physics_process(true)
		
func _input(event):
	if event.is_action_pressed("pick_up"):            
		hasGarb = true        
	if event.is_action_released("pick_up"):        
		hasGarb = false            

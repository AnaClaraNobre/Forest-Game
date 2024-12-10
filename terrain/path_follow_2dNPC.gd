extends PathFollow2D

@export var speed: float = 25.0
var direction: Vector2 = Vector2.ZERO

@onready var character = $CharacterBody2D
@onready var animated_sprite = character.get_node("AnimatedSprite2D")
@onready var path2d = get_parent()

var started: bool = false

func _ready():
	character.visible = false
	
	await get_tree().create_timer(4).timeout
	
	started = true
	character.visible = true

func _process(delta):
	if not path2d:
		return

	if not started:
		return
	
	progress_ratio += (speed / path2d.curve.get_baked_length()) * delta
	if not loop and progress_ratio >= 1.0:
		speed = 0
		return

	var next_pos = global_position
	var current_pos = character.global_position
	direction = (next_pos - current_pos).normalized()

	character.velocity = direction * speed 
	
	character.move_and_slide() 
	
	_update_animation()

func _update_animation():
	if direction.x != 0:
		animated_sprite.play("walk_side")
		if direction.x > 0:
			animated_sprite.scale.x = 1
		else:
			animated_sprite.scale.x = -1
	elif direction.y > 0:
		animated_sprite.play("walk_down")
	elif direction.y < 0:
		animated_sprite.play("walk_up")
	else:
		animated_sprite.play("walk_side")

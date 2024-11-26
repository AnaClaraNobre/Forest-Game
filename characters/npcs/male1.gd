extends CharacterBody2D

@export var speed : float = 200
@onready var animation_player = $Animation

func _process(delta):
	var velocity = Vector2.ZERO
	
	velocity = velocity.normalized() * speed
	
	self.velocity = velocity

	move_and_slide()

	if velocity.y > 0:
		animation_player.play("walk_down")
	elif velocity.x != 0:
		animation_player.play("walk_side")
	else:
		animation_player.play("idle")	

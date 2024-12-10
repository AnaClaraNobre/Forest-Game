extends Control

@onready var score = $Score:
	set(value):
		score.text = str(value)

@onready var clock = $Label:
	set(value):
		clock.text = str(value)

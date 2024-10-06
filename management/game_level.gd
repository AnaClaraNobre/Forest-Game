extends Node2D

var label = Label 
var time = Timer
@export var redclr : Color
@export var origClr : Color
# Called when the node enters the scene tree for the first time.
func _ready():
	label = $Label
	time = $Timer
	time.start()
	OriginClrRet()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_label_text()
	
	if time.time_left <= 10:
		label.modulate = redclr
	else:
		OriginClrRet()
func OriginClrRet():
	label.modulate = origClr
func update_label_text():
	label.text = str(ceil(time.time_left))

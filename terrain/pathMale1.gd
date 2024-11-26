extends PathFollow2D

@export var speed = 50.0
@export var pause_duration = 2.0  # Duração do intervalo em segundos
var moving_forward = true
var is_paused = false

@onready var timer = Timer.new()

func _ready():
	# Configurando o temporizador
	timer.one_shot = true
	timer.wait_time = pause_duration
	timer.timeout.connect(_on_timer_timeout)  # Usando Callable no Godot 4
	add_child(timer)

func _process(delta):
	if is_paused:
		return  # Pausa o movimento enquanto o timer está ativo

	var curve = get_parent().curve
	if curve == null:
		return 

	var path_length = curve.get_baked_length()

	# Atualiza a posição ao longo do caminho
	if moving_forward:
		progress_ratio += speed * delta / path_length
	else:
		progress_ratio -= speed * delta / path_length

	# Verifica se atingiu os limites e pausa
	if progress_ratio >= 1.0:
		progress_ratio = 1.0
		moving_forward = false
		pause_movement()
	elif progress_ratio <= 0.0:
		progress_ratio = 0.0
		moving_forward = true
		pause_movement()

func pause_movement():
	is_paused = true
	timer.start()  # Inicia o temporizador para aguardar

func _on_timer_timeout():
	is_paused = false  # Retoma o movimento após o timer terminar

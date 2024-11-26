extends CharacterBody2D

# Referência ao PathFollow2D
@export var path_follow_node: NodePath

# Velocidade do NPC
@export var speed: float = 200

# Referência ao AnimatedSprite2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Última posição para calcular a direção
var last_position: Vector2

# Referência ao PathFollow2D
var path_follow: PathFollow2D = null

# Comprimento do caminho
var path_length: float = 1.0

# Função chamada ao iniciar a cena
func _ready():
	# Inicializa a última posição
	last_position = global_position

	# Configura o PathFollow2D
	path_follow = get_node_or_null(path_follow_node)
	if path_follow:
		path_follow.progress = 0  # Inicia do começo do caminho
		var parent_path = path_follow.get_parent()
		if parent_path and parent_path is Path2D:
			path_length = parent_path.curve.get_baked_length()  # Obtém o comprimento do caminho

# Função chamada a cada quadro (processamento normal)
func _process(delta: float):
	if path_follow:
		# Incrementa o progresso com base no delta (tempo entre quadros)
		path_follow.progress += speed * delta / path_length
		if path_follow.progress > 1.0:
			path_follow.progress = 1.0  # Garante que não ultrapasse o limite

		# Atualiza a posição do NPC para seguir o PathFollow2D
		global_position = path_follow.global_position

		# Atualiza a animação com base na direção
		update_animation()

		# Verifica se chegou ao final do caminho
		if path_follow.progress >= 1.0:
			stop_movement()

# Função para atualizar animações
func update_animation():
	# Calcula a direção do movimento
	var direction = (global_position - last_position).normalized()

	# Define a animação com base na direção
	if direction.x > 0:
		animated_sprite.play("walk_side")
	elif direction.x < 0:
		animated_sprite.play("walk_side")
	elif direction.y > 0:
		animated_sprite.play("walk_down")
	elif direction.y < 0:
		animated_sprite.play("walk_up")

	# Atualiza a última posição
	last_position = global_position

# Função para parar o movimento e mudar para a animação idle
func stop_movement():
	# Para o NPC e muda a animação para idle
	animated_sprite.play("idle")
	print("NPC chegou ao fim do caminho!")

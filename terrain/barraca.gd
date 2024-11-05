extends Area2D
@export var player: NodePath  # Caminho para o nó do personagem

func _ready() -> void:
	# Conecta o sinal de colisão com o personagem
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	# Verifica se o corpo que colidiu é o personagem
	if body is Mia:
		body._clearGarbage()  # Chama a função clearGarbage do personagem

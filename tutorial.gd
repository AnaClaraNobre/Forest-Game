extends Node2D

@export var dialogos = [
	"Este parque era um lugar mágico, cheio de risos e memórias. Mia, ainda criança, vinha aqui com sua avó, que adorava cada canto deste lugar. Mas o tempo passou, e o parque foi abandonado. Agora, Mia está determinada a restaurar o parque e trazer de volta suas melhores lembranças.", 
	"Use W, A, S, D para mover Mia pelo parque.", 
	"Aperte F para coletar lixo.",
	"Mia lembra como o parque era limpo e vibrante. Para restaurá-lo, ela precisa começar pelo básico: recolher o lixo espalhado.",
	"Agora você sabe o que fazer! Ajude Mia a restaurar o parque e resgatar suas memórias mais preciosas."
]
var indice_fala = 0

func _ready():
	exibir_fala()

func exibir_fala():
	if indice_fala < dialogos.size():
		var fala_atual = dialogos[indice_fala]
		$tutorial.text = fala_atual
	else:
		finalizar_dialogo()

func _input(event):
	if event.is_action_pressed("ui_accept"): # Avança o texto ao pressionar Enter ou Espaço
		indice_fala += 1
		exibir_fala()

func finalizar_dialogo():
	$tutorial.hide() # Esconde o painel após o diálogo
	# Troca para a cena do primeiro nível
	get_tree().change_scene_to_file("res://management/game_level.tscn")

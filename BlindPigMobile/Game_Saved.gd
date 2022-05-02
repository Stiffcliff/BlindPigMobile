extends Control

onready var currscene = get_tree().get_current_scene().get_name()
onready var label = $SavedPanel/SavedContainer/GameSavedLabel
onready var player_vars = get_node("/root/PlayerVariables")

func _ready():
	if (str(currscene)=="Options"):
		label.text="Game Saved"
		print("1")
	else:
		label.text=("New Rank:"+str(player_vars.rank))
		print("2")
	

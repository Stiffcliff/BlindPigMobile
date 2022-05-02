extends Panel

onready var Weap =$WeaponsTab
onready var haha= $VBoxContainer3
onready var player_vars = get_node("/root/PlayerVariables")
var equipM
var equipR

func _ready():
	equipM = player_vars.meleeEquip
	equipR = player_vars.rangeEquip
	print(str(equipM))
	print(str(equipR))
	
	

func _on_CloseButton_pressed():
	get_parent().get_node("InventoryPanel").hide()
	equipM = player_vars.meleeEquip
	equipR = player_vars.rangeEquip
	print(str(equipM))
	print(str(equipR))
	pass # Replace with function body.

func _on_ChangeWpnsBtn_pressed():
	Weap.show()
	
	

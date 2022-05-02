extends Panel

onready var player_vars = get_node("/root/PlayerVariables")
onready var aniplayer3 = $AnimationPlayer3
onready var dropdowntext = $Game_Saved/SavedPanel/SavedContainer/GameSavedLabel
onready var fists = $ScrollContainer/VBoxContainer/FistsContainer
onready var pistol = $ScrollContainer/VBoxContainer/HandgunContainer
onready var rifle = $ScrollContainer/VBoxContainer/RifleContainer
onready var dusters = $ScrollContainer/VBoxContainer/DustersContainer


func _ready():
	if bool(player_vars.FistsUnlock)==true:
		fists.show()
	if bool(player_vars.PistolUnlock)==true:
		pistol.show()
	if bool(player_vars.RifleUnlock)==true:
		rifle.show()
	if bool(player_vars.DustersUnlock)==true:
		dusters.show()

func _on_btnClose_pressed():
	get_parent().get_node("WeaponsTab").hide()


func _on_btnEquip1_pressed():
	player_vars.meleeEquip=str("Fists")
	player_vars.equipMeleeDmgMax=str("2")
	player_vars.equipMeleeDmgMin=str("0")
	player_vars.equipMeleeCrit=str("10")
	player_vars.equipMeleeCrit=int(player_vars.equipMeleeCrit)+int(player_vars.totalcritboost)
	dropdowntext.text=("Equip Melee: "+str(player_vars.meleeEquip))
	_run_ani()
	

func _run_ani():
	aniplayer3.play("SaveDown")
	yield(aniplayer3, "animation_finished")


func _on_btnEquip2_pressed():
	player_vars.rangeEquip=str("Handgun")
	player_vars.equipRangeDmgMax=str("5")
	player_vars.equipRangeDmgMin=str("2")
	player_vars.equipRangeCrit=str("8")
	player_vars.equipRangeCrit=int(player_vars.equipRangeCrit)+int(player_vars.totalcritboost)
	dropdowntext.text=("Equip Ranged: "+str(player_vars.rangeEquip))
	_run_ani()


func _on_btnEquip3_pressed():
	player_vars.rangeEquip=str("Rifle")
	player_vars.equipRangeDmgMax=str("10")
	player_vars.equipRangeDmgMin=str("3")
	player_vars.equipRangeCrit=str("15")
	player_vars.equipRangeCrit=int(player_vars.equipRangeCrit)+int(player_vars.totalcritboost)
	dropdowntext.text=("Equip Ranged: "+str(player_vars.rangeEquip))
	_run_ani()


func _on_btnEquip4_pressed():
	player_vars.meleeEquip=str("Dusters")
	player_vars.equipMeleeDmgMax=str("3")
	player_vars.equipMeleeDmgMin=str("1")
	player_vars.equipMeleeCrit=str("12")
	player_vars.equipMeleeCrit=int(player_vars.equipMeleeCrit)+int(player_vars.totalcritboost)
	dropdowntext.text=("Equip Melee: "+str(player_vars.meleeEquip))
	_run_ani()

extends Control

onready var player_vars = get_node("/root/PlayerVariables")

onready var health = $StatsPanel/StatsContainer/Health
onready var ammo = $StatsPanel/StatsContainer/Ammo
onready var rep = $StatsPanel/StatsContainer/Rep
onready var money = $StatsPanel/StatsContainer/Money
onready var aniplayer =$AnimationPlayer
onready var Inv =$InventoryPanel

onready var RankLbl=$InventoryPanel/VBoxContainer/RankLbl
onready var RepLbl=$InventoryPanel/VBoxContainer/RepLbl
onready var HealthLbl=$InventoryPanel/VBoxContainer/HealthLbl

onready var RangedLbl=$InventoryPanel/VBoxContainer2/RangedLbl
onready var MeleeLbl=$InventoryPanel/VBoxContainer2/MeleeLbl
onready var AmmoLbl=$InventoryPanel/VBoxContainer2/AmmoLbl
onready var DefLbl=$InventoryPanel/VBoxContainer2/DefLbl
onready var ItemLbl=$InventoryPanel/VBoxContainer2/ItemLbl



func _ready():
	
	health.text="Health\n"+str(player_vars.health)
	ammo.text="Ammo\n"+str(player_vars.ammo)
	rep.text="Rep\n"+str(player_vars.rep)
	money.text="Money\n$"+str(player_vars.money)
	
	
func _on_Button1_pressed():
	aniplayer.play("FADE4")
	yield(aniplayer, "animation_finished")
	get_tree().change_scene("res://UI_LItalyMap.tscn")
	
	
func _on_Button2_pressed():
	aniplayer.play("FADE4")
	yield(aniplayer, "animation_finished")
	get_tree().change_scene("res://UI_UEastMap.tscn")
	


func _on_Button3_pressed():
	aniplayer.play("FADE4")
	yield(aniplayer, "animation_finished")
	get_tree().change_scene("res://UI_LEastMap.tscn")
	


func _on_Button4_pressed():
	aniplayer.play("FADE4")
	yield(aniplayer, "animation_finished")
	get_tree().change_scene("res://UI_HarlemMap.tscn")
	


func _on_Button5_pressed():
	
	RankLbl.text="Rank: "+player_vars.rank
	RepLbl.text="Reputation: "+player_vars.rep+"/"+player_vars.repNeeded
	HealthLbl.text="Health: "+player_vars.health+"/"+player_vars.maxHealth
	
	RangedLbl.text="Ranged: "+player_vars.rangeEquip
	MeleeLbl.text="Melee: "+player_vars.meleeEquip
	ItemLbl.text="Item: "+str(player_vars.itemEquip)
	AmmoLbl.text="Ammo: "+player_vars.ammo
	DefLbl.text="Defence: "+str(player_vars.defence)
	
	Inv.show()



func _on_Button6_pressed():
	aniplayer.play("FADE4")
	yield(aniplayer, "animation_finished")
	get_tree().change_scene("res://IGOptions.tscn")
	

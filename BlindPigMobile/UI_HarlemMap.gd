extends Control

onready var player_vars = get_node("/root/PlayerVariables")


onready var health = $StatsPanel/StatsContainer/Health
onready var ammo = $StatsPanel/StatsContainer/Ammo
onready var rep = $StatsPanel/StatsContainer/Rep
onready var money = $StatsPanel/StatsContainer/Money
onready var aniplayer2 =$AnimationPlayer

onready var Inv =$InventoryPanel

onready var RankLbl=$InventoryPanel/VBoxContainer/RankLbl
onready var RepLbl=$InventoryPanel/VBoxContainer/RepLbl
onready var HealthLbl=$InventoryPanel/VBoxContainer/HealthLbl

onready var RangedLbl=$InventoryPanel/VBoxContainer2/RangedLbl
onready var MeleeLbl=$InventoryPanel/VBoxContainer2/MeleeLbl
onready var MoneyLbl=$InventoryPanel/VBoxContainer2/MoneyInvLbl
onready var AmmoLbl=$InventoryPanel/VBoxContainer2/AmmoLbl
onready var CritboostLbl=$InventoryPanel/VBoxContainer2/CritBoostLbl

onready var CosaLbl=$InventoryPanel/VBoxContainer3/CosaLbl
onready var UndzerLbl=$InventoryPanel/VBoxContainer3/UndzerLbl
onready var PavLbl=$InventoryPanel/VBoxContainer3/PavLbl
onready var MobLbl=$InventoryPanel/VBoxContainer3/MobLbl
onready var ItemLbl=$InventoryPanel/VBoxContainer2/ItemLbl
onready var playerani = $GraphicsPanel/PlayerAnimator

onready var theback = $GraphicsPanel/AnimatedSprite

func _ready():
	theback.play("default")
	playerani.play("IDLE2")
	health.text="Health\n"+str(player_vars.health)
	ammo.text="Ammo\n"+str(player_vars.ammo)
	rep.text="Rep\n"+str(player_vars.rep)
	money.text="Money\n$"+str(player_vars.money)
	
func _on_Button1_pressed():
	if str(player_vars.rank)=="Godfather":
		aniplayer2.play("FADE8")
		yield(aniplayer2, "animation_finished")
		get_tree().change_scene("res://GodCombat.tscn")
		
	aniplayer2.play("FADE8")
	yield(aniplayer2, "animation_finished")
	get_tree().change_scene("res://HarCombat.tscn")
	
func _on_Button2_pressed():
	aniplayer2.play("FADE8")
	yield(aniplayer2, "animation_finished")
	get_tree().change_scene("res://Hrlm_Clinic.tscn")


func _on_Button3_pressed():
	aniplayer2.play("FADE8")
	yield(aniplayer2, "animation_finished")
	get_tree().change_scene("res://Hrlm_3Card.tscn")


func _on_Button4_pressed():
	aniplayer2.play("FADE8")
	yield(aniplayer2, "animation_finished")
	get_tree().change_scene("res://Hrlm_General.tscn")


func _on_Button5_pressed():
	RankLbl.text="Rank: "+str(player_vars.rank)
	RepLbl.text="Reputation: "+str(player_vars.rep)+"/"+str(int(player_vars.repNeeded)+(int(player_vars.rep)))
	HealthLbl.text="Health: "+str(player_vars.health)+"/"+str(player_vars.maxHealth)
	
	RangedLbl.text="Ranged: "+str(player_vars.rangeEquip)
	MoneyLbl.text="Money: $"+str(player_vars.money)
	MeleeLbl.text="Melee: "+str(player_vars.meleeEquip)
	AmmoLbl.text="Ammo: "+str(player_vars.ammo)
	CritboostLbl.text="Crit Boost: "+str(player_vars.totalcritboost)
	
	CosaLbl.text="Cosa Nostra: "+str(player_vars.CosaRep)
	UndzerLbl.text="Undzer Shtik: "+str(player_vars.UndzerRep)
	PavLbl.text="Pavees: "+str(player_vars.PavRep)
	MobLbl.text="Harlem Mob: "+str(player_vars.MobRep)
	
	Inv.show()


func _on_Button6_pressed():
	aniplayer2.play("FADE8")
	yield(aniplayer2, "animation_finished")
	get_tree().change_scene("res://UI_Map.tscn")

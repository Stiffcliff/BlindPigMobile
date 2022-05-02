extends Control

onready var player_vars = get_node("/root/PlayerVariables")

onready var health = $StatsPanel/StatsContainer/Health
onready var ammo = $StatsPanel/StatsContainer/Ammo
onready var rep = $StatsPanel/StatsContainer/Rep
onready var money = $StatsPanel/StatsContainer/Money
onready var aniplayer2 =$AnimationPlayer

onready var Inv =$InventoryPanel

onready var textbox = $TextPanel/Label

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

onready var ContBtns = $ContractChoiceContainer
onready var accBtn = $AcceptBtn

onready var cont1 = $GraphicsPanel/Cont1
onready var cont2 = $GraphicsPanel/Cont2
onready var cont3 = $GraphicsPanel/Cont3

onready var proglbl = $GraphicsPanel/ProgTextLbl
onready var checklbl = $GraphicsPanel/CheckupLbl

onready var claimBtn = $ClaimBtn
onready var ItemLbl=$InventoryPanel/VBoxContainer2/ItemLbl
onready var bossman = $GraphicsPanel/AnimatedSprite
var screen

var active
func _ready():
	bossman.play("default")
	claimBtn.hide()
	proglbl.hide()
	checklbl.hide()
	
	accBtn.hide()
	screen=0
	ContBtns.show()
	active=false
	
	if player_vars.contractFailed==true:
		player_vars.winContract=false
		player_vars.healContract=false
		player_vars.bruteContract=false
		player_vars.bruteContractCount=0
		player_vars.healContractCount=0
		player_vars.winContractCount=0
		player_vars.contractFailed==false
		textbox.text="Looks like you failed me\nGuess you can try again"
		
	
	if player_vars.bruteContract == true:
		active=true
		ContBtns.hide()
		cont1.show()
		textbox.text="Lets see how you're getting on"
		checklbl.text=str(player_vars.bruteContractCount)+"/5"
		proglbl.show()
		checklbl.show()
		if int(player_vars.bruteContractCount==5):
			_claim_reward()
		
	elif player_vars.healContract == true:
		active=true
		ContBtns.hide()
		cont2.show()
		textbox.text="Lets see how you're getting on"
		checklbl.text=str(player_vars.healContractCount)+"/5"
		proglbl.show()
		checklbl.show()
		if int(player_vars.healContractCount==5):
			_claim_reward()
		
	elif player_vars.winContract == true:
		active=true
		ContBtns.hide()
		cont3.show()
		textbox.text="Lets see how you're getting on"
		checklbl.text=str(player_vars.winContractCount)+"/8"
		proglbl.show()
		checklbl.show()
		if int(player_vars.winContractCount==5):
			_claim_reward()
	
	
		

	health.text="Health\n"+str(player_vars.health)
	ammo.text="Ammo\n"+str(player_vars.ammo)
	rep.text="Rep\n"+str(player_vars.rep)
	money.text="Money\n$"+str(player_vars.money)	
	
func _claim_reward():
	textbox.text="Good job with the contract\nHere's your reward."
	claimBtn.show()
	
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
	if screen == 0:
		aniplayer2.play("FADE6")
		yield(aniplayer2, "animation_finished")
		get_tree().change_scene("res://UI_LItalyMap.tscn")
	else:
		accBtn.hide()
		screen=0
		cont1.hide()
		cont2.hide()
		cont3.hide()
		ContBtns.show()


func _on_OptionBtn1_pressed():
	screen=1
	ContBtns.hide()
	cont1.show()
	accBtn.show()


func _on_OptionBtn2_pressed():
	screen=2
	ContBtns.hide()
	cont2.show()
	accBtn.show()


func _on_OptionBtn3_pressed():
	screen=3
	ContBtns.hide()
	cont3.show()
	accBtn.show()


func _on_AcceptBtn_pressed():
	match screen:
		1:
			player_vars.bruteContract = true
			player_vars.bruteContractCount = 0
			player_vars.contractFailed=false
		2:
			player_vars.healContract = true
			player_vars.healContractCount = 0
			player_vars.contractFailed=false
		3:
			player_vars.winContract = true
			player_vars.winContractCount = 0
			player_vars.contractFailed=false
	
	_ready()


func _on_ClaimBtn_pressed():
	if player_vars.bruteContract == true:
		player_vars.bruteContract = false
		player_vars.bruteContractCount = 0
		player_vars.money=int(player_vars.money)+10
		
	elif player_vars.healContract == true:
		player_vars.healContract = false
		player_vars.healContractCount = 0
		player_vars.money=int(player_vars.money)+10
		
	elif player_vars.winContract == true:
		player_vars.winContract = false
		player_vars.winContractCount = 0
		player_vars.money=int(player_vars.money)+10
	
	_ready()

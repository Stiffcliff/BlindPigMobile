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
onready var ItemLbl=$InventoryPanel/VBoxContainer2/ItemLbl

onready var allitems = $ScrollContainer

onready var ammobtn = $ScrollContainer/ItemChoiceContainer/OptionBtn1
onready var pistolbtn = $ScrollContainer/ItemChoiceContainer/OptionBtn2
onready var riflebtn = $ScrollContainer/ItemChoiceContainer/OptionBtn3
onready var dustersbtn = $ScrollContainer/ItemChoiceContainer/OptionBtn4

onready var itemimage = $GraphicsPanel/ItemPanel/ItemImage
onready var itemeffect = $GraphicsPanel/DescPanel/EffectPanel

onready var buyorno = $BuyOrNo

onready var thedealer = $GraphicsPanel/AnimatedSprite
var itemtobuy

func _ready():
	
	thedealer.play("default")
	itemimage.texture = load("")
	itemeffect.text = ""
	buyorno.hide()
	itemtobuy=0
	allitems.show()
	if player_vars.PistolUnlock==true:
		pistolbtn.hide()
	
	if player_vars.RifleUnlock==true:
		riflebtn.hide()
	
	if player_vars.DustersUnlock==true:
		dustersbtn.hide()
			
	health.text="Health\n"+str(player_vars.health)
	ammo.text="Ammo\n"+str(player_vars.ammo)
	rep.text="Rep\n"+str(player_vars.rep)
	money.text="Money\n$"+str(player_vars.money)	


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
	aniplayer2.play("FADE6")
	yield(aniplayer2, "animation_finished")
	get_tree().change_scene("res://UI_LEastMap.tscn")


func _on_OptionBtn2_pressed():
	allitems.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/Pistol.png")
	itemeffect.text = "Pistol"
	textbox.text = "Can do some damage with that."
	itemtobuy=2


func _on_OptionBtn3_pressed():
	allitems.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/Rifle.png")
	itemeffect.text = "Rifle"
	textbox.text = "That'll hurt."
	itemtobuy=3


func _on_OptionBtn1_pressed():
	allitems.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/Ammo.jpg")
	itemeffect.text = "Ammo"
	textbox.text = "You'll need plenty."
	itemtobuy=1


func _on_NoBtn_pressed():
	_ready()


func _on_BuyBtn_pressed():
	var money = int(player_vars.money)
	var def = int(player_vars.defence)
	var crit = int(player_vars.equipMeleeCrit)
		
		
	if itemtobuy==1:
		if money-3 >= 0:
			money=money-3
			player_vars.money=money
			player_vars.ammo=int(player_vars.ammo)+1
			_ready()
		else:
			textbox.text = "Pfft not enough money for this?"
			
	if itemtobuy==2:
		if money-25 >= 0:
			money=money-25
			player_vars.money=money
			player_vars.PistolUnlock=true
			_ready()
		else:
			textbox.text = "Pfft not enough money for this?"
	
	if itemtobuy==3:
		if money-50 >= 0:
			money=money-50
			player_vars.money=money
			player_vars.RifleUnlock=true
			_ready()
		else:
			textbox.text = "You Broke?"
	
	if itemtobuy==4:
		if money-15 >= 0:
			money=money-15
			player_vars.money=money
			player_vars.DustersUnlock=true
			_ready()
		else:
			textbox.text = "You Broke?"


func _on_OptionBtn4_pressed():
	allitems.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/Dusters.png")
	itemeffect.text = "Dusters"
	textbox.text = "Have fun."
	itemtobuy=4

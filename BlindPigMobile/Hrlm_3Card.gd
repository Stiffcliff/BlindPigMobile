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

onready var WagerLbl=$GraphicsPanel/VBoxContainer/WagerLbl
onready var ReturnsLbl=$GraphicsPanel/VBoxContainer/ReturnsLbl
onready var ChoiceLbl=$GraphicsPanel/VBoxContainer/ChoiceLbl
onready var ItemLbl=$InventoryPanel/VBoxContainer2/ItemLbl

onready var StartBox=$StartContainer
onready var WagerBox=$WagerContainer
onready var BackBtn=$BottomButtons1/Button6
onready var CardBox=$CardChoiceContainer

var rand_generate = RandomNumberGenerator.new()

var beginPressed
var choice
var winner
var position

var wagersteps = [0.00,0.50,1.00,2.00,2.50,5.00,7.50,10.00]
var wagerpointer

var threecards = [0,1,0]
var wager
var returns

func _ready():
	
	beginPressed=0
	wager=0
	choice=0
	StartBox.show()
	WagerBox.hide()
	CardBox.hide()
	BackBtn.show()
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
	

func _set_init_values():
	wagerpointer=0
	wager=wagersteps[wagerpointer]
	returns=0
	WagerLbl.text="Your wager: " +str(wager)
	ReturnsLbl.text="Potential Returns: " +str(returns)
	BackBtn.text="Back"


func _on_Button6_pressed():
	
	if (beginPressed==1):
		StartBox.show()
		WagerBox.hide()
		beginPressed=0
		_set_init_values()
	
	else:
		aniplayer2.play("FADE6")
		yield(aniplayer2, "animation_finished")
		get_tree().change_scene("res://UI_HarlemMap.tscn")


func _on_IncreaseWagerBtn_pressed():
	wagerpointer=wagerpointer+1
	if (wagerpointer>7):
		wagerpointer=7
	wager=wagersteps[wagerpointer]
	_set_current_values()


func _on_DecreaseWagerBtn_pressed():
	wagerpointer=wagerpointer-1
	if (wagerpointer<0):
		wagerpointer=0
	wager=wagersteps[wagerpointer]
	_set_current_values()

func _on_BeginBtn_pressed():
	_set_init_values()
	beginPressed=1
	StartBox.hide()
	WagerBox.show()


func _set_current_values():
	WagerLbl.text="Your wager: $" +str(wager)
	returns=wager*2
	ReturnsLbl.text="Potential Returns: $" +str(returns)


func _on_ConfirmBtn_pressed():
	CardBox.show()
	if ((float(player_vars.money)-wager>=0)&&wager!=0):
		player_vars.money=float(player_vars.money)-float(wager)
		money.text="Money\n$"+str(player_vars.money)
		WagerBox.hide()
		BackBtn.hide()
		_shuffle_cards()
		
	if (float(player_vars.money)-wager<0):
		textbox.text="Not enough money for that."
		
	elif (wager==0):
		textbox.text="You can't wager nothing."

func _shuffle_cards():
	threecards.shuffle()
	if (threecards[0]==1):
		position=1
	elif (threecards[1]==1):
		position=2
	elif (threecards[2]==1):
		position=3
	
func _on_LeftCardBtn_pressed():
	choice=1
	ChoiceLbl.text="Choice: Left Card"


func _on_MidCardBtn_pressed():
	choice=2
	ChoiceLbl.text="Choice: Middle Card"

func _on_RightCardBtn_pressed():
	choice=3
	ChoiceLbl.text="Choice: Right Card"


func _on_ConfirmBtn2_pressed():
	if position==choice:
		textbox.text="You found the queen.\nTake your money"
		player_vars.money=float(player_vars.money)+float(wager)
		money.text="Money\n$"+str(player_vars.money)
		CardBox.hide()
		_ready()
	elif (position==1):
		textbox.text="The Queens on the left.\nUnlucky this time.\nWant to try again?"
		CardBox.hide()
		_ready()
	elif (position==2):
		textbox.text="The Queens in the middle.\nUnlucky this time.\nWant to try again?"
		CardBox.hide()
		_ready()
	elif (position==3):
		textbox.text="The Queens on the right.\nUnlucky this time.\nWant to try again?"
		CardBox.hide()
		_ready()

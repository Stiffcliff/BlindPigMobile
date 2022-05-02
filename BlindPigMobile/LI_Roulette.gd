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

onready var BackBtn=$BottomButtons1/Button6

onready var Choice1Box=$RouletteChoiceContainer

onready var Choice2Box=$Choice2Box
onready var Choice3Box=$Choice3Box
onready var Choice4Box=$Choice4Box

onready var WagerBox=$WagerChoiceBox

onready var WagerLbl=$GraphicsPanel/VBoxContainer/WagerLbl
onready var ReturnsLbl=$GraphicsPanel/VBoxContainer/ReturnsLbl

onready var ChoiceLbl=$GraphicsPanel/VBoxContainer/ChoiceLbl
onready var ItemLbl=$InventoryPanel/VBoxContainer2/ItemLbl

var rand_generate = RandomNumberGenerator.new()

var choice
var winner
var colour
var region

var wagersteps = [0.00,1.00,2.00,5.00,10.00,15.00,20.00,25.00,50.00,100.00]
var wagerpointer

var numberstep = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36]
var numberpointer

var wager
var returns
var rollchoice

var decided

func _ready():
	
	wager=0
	choice=0
	rollchoice=""
	health.text="Health\n"+str(player_vars.health)
	ammo.text="Ammo\n"+str(player_vars.ammo)
	rep.text="Rep\n"+str(player_vars.rep)
	money.text="Money\n$"+str(player_vars.money)
	WagerLbl.text="Your wager: $"
	ReturnsLbl.text="Potential Returns: $"
	ChoiceLbl.text="Choice: "
	Choice4Box.hide()
	Choice3Box.hide()
	Choice2Box.hide()
	WagerBox.hide()
	Choice1Box.show()
	BackBtn.show()
	BackBtn.text="Back"	

func _set_init_values():
	wagerpointer=0
	wager=wagersteps[wagerpointer]
	returns=0
	WagerLbl.text="Your wager: " +str(wager)
	ReturnsLbl.text="Potential Returns: " +str(returns)
	BackBtn.text="Back"
	

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
	if (choice!=0 && wager!=0):
		Choice2Box.hide()
		Choice3Box.hide()
		WagerBox.show()
		BackBtn.text="Change Bet"
	if (choice!=0):
		Choice1Box.show()
		WagerBox.hide()
		choice=0
		_set_init_values()
	
	else:
		aniplayer2.play("FADE6")
		yield(aniplayer2, "animation_finished")
		get_tree().change_scene("res://UI_LItalyMap.tscn")


func _on_RedBlackBtn_pressed():
	choice = 1
	_set_init_values()
	firstButtonsPressed()

func _on_GroupBtn_pressed():
	choice = 2
	_set_init_values()
	firstButtonsPressed()

func _on_SingleNumberBtn_pressed():
	choice = 3
	_set_init_values()
	firstButtonsPressed()

func firstButtonsPressed():
	Choice1Box.hide()
	WagerBox.show()
	BackBtn.text="Change Bet"
	

func _on_IncreaseWagerBtn_pressed():
	wagerpointer=wagerpointer+1
	if (wagerpointer>9):
		wagerpointer=9
	wager=wagersteps[wagerpointer]
	_set_current_values()


func _on_DecreaseWagerBtn_pressed():
	wagerpointer=wagerpointer-1
	if (wagerpointer<0):
		wagerpointer=0
	wager=wagersteps[wagerpointer]
	_set_current_values()

func _set_current_values():
	WagerLbl.text="Your wager: $" +str(wager)
	
	if (choice==1):
		returns = wager*2
	if (choice==2):
		returns = wager*3
	if (choice==3):
		returns = wager*35
	
	ReturnsLbl.text="Potential Returns: $" +str(returns)



func _on_ContinueBtn_pressed():
	
		
	if ((float(player_vars.money)-wager>=0)&&wager!=0):
		numberpointer=0
		player_vars.money=float(player_vars.money)-float(wager)
		money.text="Money\n$"+str(player_vars.money)
		WagerBox.hide()
		BackBtn.hide()
		if (choice==1):
			Choice2Box.show()
		if (choice==2):
			Choice3Box.show()	
		if (choice==3):
			Choice4Box.show()
			ChoiceLbl.text="Choice: "+str(numberstep[numberpointer])
			
		
	elif (float(player_vars.money)-wager<0):
		textbox.text="Not enough money for that."
		
	elif (wager==0):
		textbox.text="You can't wager nothing."

func _run_roll():
	
	rand_generate.randomize()
	winner = rand_generate.randi_range(0,35)
	
	if (winner%2==1):
		colour="Red"
	elif (winner%2 ==0):
		colour="Black"
	
	if (winner==0):
		colour="Green"
		
	if (winner >= 1 && winner <= 12):
		region="Region: 1"
	elif (winner>=13 && winner <= 24 ): 
		region="Region: 2"
	elif (winner>=25 && winner <= 36):
		region="Region: 3"
	else:
		region=0
			
	textbox.text="Winning Number: " +str(winner)+ "\nColour: " +str(colour)+ "\n"+str(region)
	
	if (choice==1):
		return colour
	elif (choice==2):
		return region
	elif (choice==3):
		return winner
		
func _on_RedBtn_pressed():
	ChoiceLbl.text="Choice: Red"
	rollchoice="Red"


func _on_BlackBtn_pressed():
	ChoiceLbl.text="Choice: Black"
	rollchoice="Black"


func _on_Confirm2Btn_pressed():
	if rollchoice=="":
		textbox.text="You need to make a choice." 
	else:
		decided=_run_roll()
		Choice1Box.hide()
		
		if (int(decided)==int(rollchoice)):
			player_vars.money=float(player_vars.money)+float(returns)
			textbox.text="Winning Number: " +str(winner)+ "\nColour: " +str(colour)+ "\n"+str(region)+"\nYou won!"
		else:
			textbox.text="Winning Number: " +str(winner)+ "\nColour: " +str(colour)+ "\n"+str(region)+"\nYou lost."
		_ready()

func _on_Region1Btn_pressed():
	ChoiceLbl.text="Choice: 1-12"
	rollchoice="Region: 1"


func _on_Region2Btn_pressed():
	ChoiceLbl.text="Choice: 13-24"
	rollchoice="Region: 2"


func _on_Region3Btn_pressed():
	ChoiceLbl.text="Choice: 24-35"
	rollchoice="Region: 3"


func _on_IncreaseBtn_pressed():
	numberpointer=numberpointer+1
	if (numberpointer>35):
		numberpointer=35
	ChoiceLbl.text="Choice: "+str(numberstep[numberpointer])
	rollchoice=str(numberstep[numberpointer])
	


func _on_DecreaseBtn_pressed():
	numberpointer=numberpointer-1
	if (numberpointer<0):
		numberpointer=0
	ChoiceLbl.text="Choice: "+str(numberstep[numberpointer])
	rollchoice=str(numberstep[numberpointer])

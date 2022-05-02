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

onready var FighterNamesBox = $GraphicsPanel/VBoxContainer
onready var FighterLbl1 =$GraphicsPanel/VBoxContainer/FighterLbl1
onready var FighterLbl2 =$GraphicsPanel/VBoxContainer/FighterLbl2


onready var FighterButtons =$FighterChoiceContainer
onready var FighterBtn1 =$FighterChoiceContainer/FighterBtn1
onready var FighterBtn2 =$FighterChoiceContainer/FighterBtn2



onready var BottomButtons1 =$BottomButtons1
onready var BottomButtons2 =$BottomButtons2
onready var WagerButtons = $WagerChoiceContainer

onready var WagerLabels = $GraphicsPanel/VBoxContainer1
onready var SelectedFighterLbl = $GraphicsPanel/VBoxContainer1/SelectedFighterLbl
onready var WagerLbl = $GraphicsPanel/VBoxContainer1/YourWagerLbl
onready var ReturnLbl = $GraphicsPanel/VBoxContainer1/ReturnLbl

onready var OutcomeLabels = $GraphicsPanel/VBoxContainer2
onready var winningFighterLbl = $GraphicsPanel/VBoxContainer2/WinningFighterLbl
onready var ResultLbl = $GraphicsPanel/VBoxContainer2/ResultLbl
onready var OutcomeLbl = $GraphicsPanel/VBoxContainer2/OutcomeLbl

onready var ContinueContainer = $ContinueContainer
onready var ItemLbl=$InventoryPanel/VBoxContainer2/ItemLbl

var chosenFighter = ""

var rand_generate = RandomNumberGenerator.new()
var rand_generate2 = RandomNumberGenerator.new()
var rand_generate3 = RandomNumberGenerator.new()

var Fighter1name
var Fighter2name


var Fighter1odds
var Fighter2odds


var wager
var returns
var selectedFighterOdds
var OddsMutliplier

var wagersteps = [0.00,0.50,1.00,2.00,2.50,5.00,7.50,10.00,15.00,25.00]
var wagerpointer

var Fighter1converted
var Fighter2converted

var winner
var selectedFighter

var winningFighterName

func _ready():
	
	chosenFighter = "none"
	health.text="Health\n"+str(player_vars.health)
	ammo.text="Ammo\n"+str(player_vars.ammo)
	rep.text="Rep\n"+str(player_vars.rep)
	money.text="Money\n$"+str(player_vars.money)	

	generate_Fighter()

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
	
func generate_Fighter():
	
	var FighterNames = ["Iron Mike","Gypsy Mick","Big Ben","Mr Dandy","John Seema","Andrew Da Giant","Sister Escobar","Barney Boss","Hank Punchwell","Max Powers","Tough Frank","Congo John","Shady Crooks","Condor McGrazer","Norris"]
	
	var Fighter1
	var Fighter2

	
	var FighterComplete = false
	var OddsComplete = false
	
	var fromFighter = 0
	var toFighter = 14
	
	var fromOdds = 20
	var toOdds = 80
	
	while(FighterComplete == false):
		
		rand_generate.randomize()
		
		Fighter1 = rand_generate.randi_range(fromFighter,toFighter)
		Fighter2 = rand_generate.randi_range(fromFighter,toFighter)
	
		
		if(Fighter1 != Fighter2):
			Fighter1name=FighterNames[Fighter1]
			Fighter2name=FighterNames[Fighter2]
			FighterComplete=true
			
	while(OddsComplete == false):
		
		rand_generate2.randomize()
		
		Fighter1odds = rand_generate2.randi_range(fromOdds,toOdds)
		toOdds = toOdds-Fighter1odds
		Fighter2odds = toOdds
		OddsComplete = true
	
	Fighter1converted=convert_to_odds(Fighter1odds)
	Fighter2converted=convert_to_odds(Fighter2odds)
	
		
	FighterLbl1.text = "Fighter 1: "+str(Fighter1name)+" "+str(Fighter1converted)+"/1"
	FighterLbl2.text = "Fighter 2: "+str(Fighter2name)+" "+str(Fighter2converted)+"/1"


	
	FighterBtn1.text=Fighter1name
	FighterBtn2.text=Fighter2name



func _on_FighterBtn1_pressed():
	chosenFighter=Fighter1name
	selectedFighterOdds=Fighter1converted
	selectedFighter=1
	_set_init_values()
	buttons_function1()


func _on_FighterBtn2_pressed():
	chosenFighter=Fighter2name
	selectedFighterOdds=Fighter2converted
	selectedFighter=2
	_set_init_values()
	buttons_function1()

	
func buttons_function1():
	FighterButtons.hide()
	BottomButtons1.hide()
	BottomButtons2.show()
	FighterNamesBox.hide()
	WagerButtons.show()
	WagerLabels.show()

func _on_ChangeBtn_pressed():
	textbox.text="Welcome to the pits."
	FighterButtons.show()
	BottomButtons1.show()
	BottomButtons2.hide()
	FighterNamesBox.show()
	WagerButtons.hide()
	WagerLabels.hide()

func result_button_function():
	WagerLabels.hide()
	WagerButtons.hide()
	BottomButtons2.hide()
	BottomButtons1.show()
	OutcomeLabels.show()
	ContinueContainer.show()

func _set_init_values():
	wagerpointer=0
	wager=wagersteps[wagerpointer]
	returns=selectedFighterOdds*wager
	SelectedFighterLbl.text="Your Fighter: " +str(chosenFighter)
	WagerLbl.text="Your wager: $" +str(wager)
	ReturnLbl.text="Potential Return: $"+str(returns)
	

func _set_current_values():
	SelectedFighterLbl.text="Your Fighter: " +str(chosenFighter)
	WagerLbl.text="Your wager: $" +str(wager)
	ReturnLbl.text="Potential Return: $"+str(returns)
	
func _on_IncreaseWagerBtn_pressed():
	wagerpointer=wagerpointer+1
	if (wagerpointer>9):
		wagerpointer=9
	wager=wagersteps[wagerpointer]
	returns=(wager*selectedFighterOdds)+wager
	_set_current_values()
	

func _on_DecreaseWagerBtn_pressed():
	wagerpointer=wagerpointer-1
	if (wagerpointer<0):
		wagerpointer=0
	wager=wagersteps[wagerpointer]
	returns=(wager*selectedFighterOdds)+wager
	_set_current_values()
	

func _on_ConfirmWagerBtn_pressed():
	
	if ((float(player_vars.money)-wager>=0)&&wager!=0):
		textbox.text="Welcome to the pits."
		player_vars.money=float(player_vars.money)-float(wager)
		var winningFighter
		
		winningFighter=run_fight()
		
		if winningFighter==1:
			winningFighterName=Fighter1name
			
		
		if winningFighter==2:
			winningFighterName=Fighter2name
		
		if winningFighter==0:
			winningFighterName="Split Decision"
			
		winningFighterLbl.text="Winning Fighter: "+str(winningFighterName)
		
		if (winningFighterName==chosenFighter):
			ResultLbl.text="Your Fighter won"
			OutcomeLbl.text="You made: $" +str(returns)
			player_vars.money=float(player_vars.money)+float(returns)
			textbox.text="Congratulations\nNice win."

		elif (winningFighterName != chosenFighter && (winningFighter==1 or winningFighter==2)):
			ResultLbl.text="Your Fighter didn't win"
			OutcomeLbl.text="You lost: $"+str(wager)
			textbox.text="Unfortunate,\nThat's just how it goes."
		
		elif (winningFighterName != chosenFighter && winningFighter==0):
			ResultLbl.text="The fight was a tie"
			OutcomeLbl.text="You get half your wager back"
			textbox.text="A let down for sure"
			player_vars.money=float(player_vars.money)+float(wager/2)
		
		chosenFighter = "none"
		health.text="Health\n"+str(player_vars.health)
		ammo.text="Ammo\n"+str(player_vars.ammo)
		rep.text="Rep\n"+str(player_vars.rep)
		money.text="Money\n$"+str(player_vars.money)
		
		result_button_function()
	
	if (float(player_vars.money)-wager<0):
		textbox.text="Not enough money for that."
	elif (wager==0):
		textbox.text="You can't wager nothing."
	
	
func convert_to_odds(FighterPercentage):
	
	float(FighterPercentage)
	if FighterPercentage==0:
		FighterPercentage=0.1
	FighterPercentage=FighterPercentage/100
	if FighterPercentage==0:
		FighterPercentage=0.1
	FighterPercentage=1/FighterPercentage
	if FighterPercentage==0:
		FighterPercentage=0.1
	FighterPercentage=FighterPercentage-1
	
	
	if (FighterPercentage<1):
		FighterPercentage=ceil(FighterPercentage)
	else:
		FighterPercentage=int(round(FighterPercentage))
			
	return FighterPercentage

func run_fight():
	var FightArray=[]
	var x=0
	var y=0
	var z=0
	
	while (x!=100):
		FightArray.append(0)
		x=x+1
	
	x=0
	
	while(x!=Fighter1odds):
		FightArray[x]=1
		x=x+1
		
	while(y!=Fighter2odds):
		FightArray[x]=2
		x=x+1
		y=y+1
	
	FightArray.shuffle()
	print(FightArray)
	rand_generate3.randomize()
		
	winner = rand_generate3.randi_range(0,99)
	
	winner = FightArray[winner]
	
	return winner
	


func _on_ContinueBtn_pressed():
	generate_Fighter()
	OutcomeLabels.hide()
	ContinueContainer.hide()
	FighterNamesBox.show()
	FighterButtons.show()


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

onready var HorseNamesBox = $GraphicsPanel/VBoxContainer
onready var HorseLbl1 =$GraphicsPanel/VBoxContainer/HorseLbl1
onready var HorseLbl2 =$GraphicsPanel/VBoxContainer/HorseLbl2
onready var HorseLbl3 =$GraphicsPanel/VBoxContainer/HorseLbl3

onready var HorseButtons =$HorseChoiceContainer
onready var HorseBtn1 =$HorseChoiceContainer/HorseBtn1
onready var HorseBtn2 =$HorseChoiceContainer/HorseBtn2
onready var HorseBtn3 =$HorseChoiceContainer/HorseBtn3


onready var BottomButtons1 =$BottomButtons1
onready var BottomButtons2 =$BottomButtons2
onready var WagerButtons = $WagerChoiceContainer

onready var WagerLabels = $GraphicsPanel/VBoxContainer1
onready var SelectedHorseLbl = $GraphicsPanel/VBoxContainer1/SelectedHorseLbl
onready var WagerLbl = $GraphicsPanel/VBoxContainer1/YourWagerLbl
onready var ReturnLbl = $GraphicsPanel/VBoxContainer1/ReturnLbl

onready var OutcomeLabels = $GraphicsPanel/VBoxContainer2
onready var winningHorseLbl = $GraphicsPanel/VBoxContainer2/WinningHorseLbl
onready var ResultLbl = $GraphicsPanel/VBoxContainer2/ResultLbl
onready var ItemLbl=$InventoryPanel/VBoxContainer2/ItemLbl
onready var OutcomeLbl = $GraphicsPanel/VBoxContainer2/OutcomeLbl

onready var ContinueContainer = $ContinueContainer

var chosenHorse = ""

var rand_generate = RandomNumberGenerator.new()
var rand_generate2 = RandomNumberGenerator.new()
var rand_generate3 = RandomNumberGenerator.new()

var horse1name
var horse2name
var horse3name

var horse1odds
var horse2odds
var horse3odds

var wager
var returns
var selectedHorseOdds
var OddsMutliplier

var wagersteps = [0.00,1.00,2.00,5.00,10.00,15.00,20.00,25.00,50.00,100.00]
var wagerpointer

var horse1converted
var horse2converted
var horse3converted

var winner
var selectedHorse

var winningHorseName

func _ready():
	
	chosenHorse = "none"
	health.text="Health\n"+str(player_vars.health)
	ammo.text="Ammo\n"+str(player_vars.ammo)
	rep.text="Rep\n"+str(player_vars.rep)
	money.text="Money\n$"+str(player_vars.money)	

	generate_horses()

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
	get_tree().change_scene("res://UI_UEastMap.tscn")
	
func generate_horses():
	
	var horsenames = ["The Duke","Chad","Shergar","Chief","Chef","Red Rum","Ned","Hell Bent","Heaven Sent","Papyrus","Waygood","Entreaty","Gallahad","Tranquil","Zev"]
	
	var horse1
	var horse2
	var horse3
	
	var HorseComplete = false
	var OddsComplete = false
	
	var fromHorse = 0
	var toHorse = 14
	
	var fromOdds = 1
	var toOdds = 100
	
	while(HorseComplete == false):
		
		rand_generate.randomize()
		
		horse1 = rand_generate.randi_range(fromHorse,toHorse)
		horse2 = rand_generate.randi_range(fromHorse,toHorse)
		horse3 = rand_generate.randi_range(fromHorse,toHorse)
		
		if(horse1 != horse2 && horse1 != horse3 && horse2 != horse3):
			horse1name=horsenames[horse1]
			horse2name=horsenames[horse2]
			horse3name=horsenames[horse3]
			HorseComplete=true
			
	while(OddsComplete == false):
		
		rand_generate2.randomize()
		
		horse1odds = rand_generate2.randi_range(fromOdds,toOdds-2)
		toOdds = toOdds-horse1odds
		horse2odds = rand_generate2.randi_range(fromOdds,toOdds-1)
		toOdds = toOdds-horse2odds
		horse3odds = toOdds
		
		OddsComplete = true
	
	horse1converted=convert_to_odds(horse1odds)
	horse2converted=convert_to_odds(horse2odds)
	horse3converted=convert_to_odds(horse3odds)
	
		
	HorseLbl1.text = "Horse 1: "+str(horse1name)+" "+str(horse1converted)+"/1"
	HorseLbl2.text = "Horse 2: "+str(horse2name)+" "+str(horse2converted)+"/1"
	HorseLbl3.text = "Horse 3: "+str(horse3name)+" "+str(horse3converted)+"/1"

	
	HorseBtn1.text=horse1name
	HorseBtn2.text=horse2name
	HorseBtn3.text=horse3name


func _on_HorseBtn1_pressed():
	chosenHorse=horse1name
	selectedHorseOdds=horse1converted
	selectedHorse=1
	_set_init_values()
	buttons_function1()


func _on_HorseBtn2_pressed():
	chosenHorse=horse2name
	selectedHorseOdds=horse2converted
	selectedHorse=2
	_set_init_values()
	buttons_function1()

func _on_HorseBtn3_pressed():
	chosenHorse=horse3name
	selectedHorseOdds=horse3converted
	selectedHorse=3
	_set_init_values()
	buttons_function1()
	
func buttons_function1():
	HorseButtons.hide()
	BottomButtons1.hide()
	BottomButtons2.show()
	HorseNamesBox.hide()
	WagerButtons.show()
	WagerLabels.show()

func _on_ChangeBtn_pressed():
	textbox.text="Welcome to the races."
	HorseButtons.show()
	BottomButtons1.show()
	BottomButtons2.hide()
	HorseNamesBox.show()
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
	returns=selectedHorseOdds*wager
	SelectedHorseLbl.text="Your horse: " +str(chosenHorse)
	WagerLbl.text="Your wager: $" +str(wager)
	ReturnLbl.text="Potential Return: $"+str(returns)
	

func _set_current_values():
	SelectedHorseLbl.text="Your horse: " +str(chosenHorse)
	WagerLbl.text="Your wager: $" +str(wager)
	ReturnLbl.text="Potential Return: $"+str(returns)
	
func _on_IncreaseWagerBtn_pressed():
	wagerpointer=wagerpointer+1
	if (wagerpointer>9):
		wagerpointer=9
	wager=wagersteps[wagerpointer]
	returns=(wager*selectedHorseOdds)+wager
	_set_current_values()
	

func _on_DecreaseWagerBtn_pressed():
	wagerpointer=wagerpointer-1
	if (wagerpointer<0):
		wagerpointer=0
	wager=wagersteps[wagerpointer]
	returns=(wager*selectedHorseOdds)+wager
	_set_current_values()
	

func _on_ConfirmWagerBtn_pressed():
	
	if ((float(player_vars.money)-wager>=0)&&wager!=0):
		textbox.text="Welcome to the races."
		player_vars.money=float(player_vars.money)-float(wager)
		var winningHorse
		
		winningHorse=run_race()
		
		if winningHorse==1:
			winningHorseName=horse1name
			
		
		if winningHorse==2:
			winningHorseName=horse2name
			
		
		if winningHorse==3:
			winningHorseName=horse3name
		
		winningHorseLbl.text="Winning Horse: "+str(winningHorseName)
		
		if (winningHorseName==chosenHorse):
			ResultLbl.text="Your horse won"
			OutcomeLbl.text="You made: $" +str(returns)
			player_vars.money=float(player_vars.money)+float(returns)
			textbox.text="Congratulations\nNice win."

		if (winningHorseName != chosenHorse):
			ResultLbl.text="Your horse didn't win"
			OutcomeLbl.text="You lost: $"+str(wager)
			textbox.text="Unfortunate,\nThat's just how it goes."
		
		chosenHorse = "none"
		health.text="Health\n"+str(player_vars.health)
		ammo.text="Ammo\n"+str(player_vars.ammo)
		rep.text="Rep\n"+str(player_vars.rep)
		money.text="Money\n$"+str(player_vars.money)
		
		result_button_function()
	
	if (float(player_vars.money)-wager<0):
		textbox.text="Not enough money for that."
	elif (wager==0):
		textbox.text="You can't wager nothing."
	
	
func convert_to_odds(horsePercentage):
	
	float(horsePercentage)
	horsePercentage=horsePercentage/100.00
	horsePercentage=1/horsePercentage
	horsePercentage=horsePercentage-1
	
	
	if (horsePercentage<1):
		horsePercentage=ceil(horsePercentage)
	else:
		horsePercentage=int(round(horsePercentage))
			
	return horsePercentage

func run_race():
	var raceArray=[]
	var x=0
	var y=0
	var z=0
	
	while (x!=100):
		raceArray.append(0)
		x=x+1
	
	x=0
	
	while(x!=horse1odds):
		raceArray[x]=1
		x=x+1
		
	while(y!=horse2odds):
		raceArray[x]=2
		x=x+1
		y=y+1
	
	while(z!=horse3odds):
		raceArray[x]=3
		x=x+1
		z=z+1
	
	raceArray.shuffle()
	
	rand_generate3.randomize()
		
	winner = rand_generate3.randi_range(0,99)
	
	winner = raceArray[winner]
	
	return winner
	


func _on_ContinueBtn_pressed():
	generate_horses()
	OutcomeLabels.hide()
	ContinueContainer.hide()
	HorseNamesBox.show()
	HorseButtons.show()


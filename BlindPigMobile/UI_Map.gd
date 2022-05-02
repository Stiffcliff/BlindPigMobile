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
onready var MoneyLbl=$InventoryPanel/VBoxContainer2/MoneyInvLbl
onready var AmmoLbl=$InventoryPanel/VBoxContainer2/AmmoLbl
onready var CritboostLbl=$InventoryPanel/VBoxContainer2/CritBoostLbl

onready var CosaLbl=$InventoryPanel/VBoxContainer3/CosaLbl
onready var UndzerLbl=$InventoryPanel/VBoxContainer3/UndzerLbl
onready var PavLbl=$InventoryPanel/VBoxContainer3/PavLbl
onready var MobLbl=$InventoryPanel/VBoxContainer3/MobLbl

onready var playerani = $GraphicsPanel/PlayerAnimator
onready var restoredPnl = $restoredPnl

onready var manhat = $GraphicsPanel/AnimatedSprite
onready var endgpnl = $EndGPnl
#establish variables when the related element is loaded


func _ready(): #ready method, executed when scene is loaded or specifcally called 
	manhat.play("default") #plays the animated sprite for the background
	playerani.play("IDLE3") #plays the idle animation of the player
	restoredPnl.hide()
	endgpnl.hide() #hides elements until needed
	
	if int(player_vars.health)==0: #if the players health is 0
		player_vars.health=int(int(player_vars.maxHealth)/2) #restore half the players health
		restoredPnl.show() #display panel with informative text
		
	if str(player_vars.rank)=="Godfather": #check if the players rank is godfather
		endgpnl.show() #display different informative panel
		
	
	_check_rep() #runs check reputation method
	
	health.text="Health\n"+str(player_vars.health)
	ammo.text="Ammo\n"+str(player_vars.ammo)
	rep.text="Rep\n"+str(player_vars.rep)
	money.text="Money\n$"+str(player_vars.money) #updates labels on the page
	
	
	
	
	
func _on_Button1_pressed(): #little italy button press event
	aniplayer.play("FADE4") #play fade animation
	yield(aniplayer, "animation_finished") #wait till animation is done
	get_tree().change_scene("res://UI_LItalyMap.tscn") #change scene to selected region
	
	
func _on_Button2_pressed():  #upper east button press event
	aniplayer.play("FADE4")  #play fade animation
	yield(aniplayer, "animation_finished") #wait till animation is done
	get_tree().change_scene("res://UI_UEastMap.tscn") #change scene to selected region
	


func _on_Button3_pressed(): #Lower east button press event
	aniplayer.play("FADE4")  #play fade animation
	yield(aniplayer, "animation_finished") #wait till animation is done
	get_tree().change_scene("res://UI_LEastMap.tscn") #change scene to selected region
	


func _on_Button4_pressed(): #harmlem button press event
	aniplayer.play("FADE4")  #play fade animation
	yield(aniplayer, "animation_finished") #wait till animation is done
	get_tree().change_scene("res://UI_HarlemMap.tscn") #change scene to selected region
	


func _on_Button5_pressed():
	
	RankLbl.text="Rank: "+player_vars.rank
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
	aniplayer.play("FADE4")
	yield(aniplayer, "animation_finished")
	get_tree().change_scene("res://IGOptions.tscn")
	
func _check_rep():
	var checkrep=int(player_vars.rep)
	
	if checkrep >=0 && checkrep <= 9:
		player_vars.rank="Unknown"
		player_vars.repNeeded=10-int(player_vars.rep)
	elif checkrep>=10 && checkrep <= 24:
		player_vars.rank="Upcoming"
		player_vars.repNeeded=25-int(player_vars.rep)
	elif checkrep>=25 && checkrep <=49:
		player_vars.rank="Felon"
		player_vars.repNeeded=50-int(player_vars.rep)
	elif checkrep>=50 && checkrep <= 99:
		player_vars.rank="Crew Member"
		player_vars.repNeeded=100-int(player_vars.rep)
	elif checkrep>=100 && checkrep <= 149:
		player_vars.rank="Associate"
		player_vars.repNeeded=150-int(player_vars.rep)
	elif checkrep>=150 && checkrep <= 199:
		player_vars.rank="Soldier"
		player_vars.repNeeded=200-int(player_vars.rep)
	elif checkrep>=200 && checkrep <= 249:
		player_vars.rank="Capo"
		player_vars.repNeeded=250-int(player_vars.rep)
	elif checkrep>=250 && checkrep <= 324:
		player_vars.rank="Consigliere"
		player_vars.repNeeded=325-int(player_vars.rep)
	elif checkrep>=325 && checkrep <= 399:
		player_vars.rank="Underboss"
		player_vars.repNeeded=400-int(player_vars.rep)
	elif checkrep>=400 && checkrep <= 499:
		player_vars.rank="Boss"
		player_vars.repNeeded=500-int(player_vars.rep)
	elif checkrep>=500:
		player_vars.rank="Godfather"

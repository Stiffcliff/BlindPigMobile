extends Control

onready var player_vars = get_node("/root/PlayerVariables")

onready var enemy = $Enemy

onready var health = $StatsPanel/StatsContainer/Health
onready var ammo = $StatsPanel/StatsContainer/Ammo
onready var rep = $StatsPanel/StatsContainer/Rep
onready var money = $StatsPanel/StatsContainer/Money
onready var aniplayer2 =$AnimationPlayer
onready var aniplayer = $AnimationPlayer2
onready var textpan = $TextPanel/Label

onready var Pdmglbl = $PDmgLbl
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
onready var Inv =$InventoryPanel

onready var playerani = $PlayerAnimator

onready var dropdowntext = $Game_Saved/SavedPanel/SavedContainer/GameSavedLabel

onready var combatoptions = $CombatOptions

onready var playerMeleeMinDmg = player_vars.equipMeleeDmgMin
onready var playerMeleeMaxDmg = player_vars.equipMeleeDmgMax
onready var playerMeleeCrit = player_vars.equipMeleeCrit

onready var playerRangeMinDmg = player_vars.equipRangeDmgMin
onready var playerRangeMaxDmg = player_vars.equipRangeDmgMax
onready var playerRangeCrit = player_vars.equipRangeCrit

onready var ExitOptions = $ExitOptions
onready var MeleeOptions = $MeleeOptions
onready var RangeOptions = $RangeOptions
onready var MoveOptions = $MovementOptions

onready var helpPanel = $helpPnl

onready var helpPanTitle = $helpPnl/Title
onready var helpPanCont = $helpPnl/Content
onready var exitBtn = $ExitOptions/Button2

onready var backBtn = $BackBtn
onready var helpBtn = $HelpBtn

var flee = 0

var invopen
var ismovement

var displayinv

var rankbefore
var rankafter


var PDmgPicker = RandomNumberGenerator.new()
var PCritPicker = RandomNumberGenerator.new()

var currentscreen
var panOpen
var skipturn 
var enemylevel
var iscrit
var critcheck
var todamage

var accadmg
var miss
var misschance
var attacktype

var resistvalue
var resistcheck
var turn = 0 
var fleechance
var enemystartinghp
var isdead

var realdmg

var magiccheck

onready var pstun = $PStunLbl
onready var pres =$PResLbl

onready var sprite = $Player

var fightlost

func _ready():
	magiccheck=false
	enemy.region = "LI"
	playerani.play("IDLE")
	ismovement=false
	var invopen = false
	exitBtn.text="Die?"
	
	if turn==0:
		pstun.hide()
		pres.hide()
		enemystartinghp=enemy.hplabel.text
		print (enemystartinghp)
		flee=false
		enemylevel = int(enemy.lvllbl.text)
		isdead=false
	
	if int(enemy.hplabel.text)>int(int(enemystartinghp)/2):
		fleechance=25
	elif int(enemy.hplabel.text)<int(int(enemystartinghp)/4):
		fleechance=75
	else:
		fleechance=50
		
	if flee==true:
		_hide_options()
		ExitOptions.show()
		print("flee check")
		return
		
	
	health.text="Health\n"+str(player_vars.health)
	ammo.text="Ammo\n"+str(player_vars.ammo)
	rep.text="Rep\n"+str(player_vars.rep)
	money.text="Money\n$"+str(player_vars.money)
	isdead=false	
	currentscreen=0
	_is_player_dead()
	if isdead==true:
		return
	
	if turn==0:
		fightlost=false
		textpan.text=("You encounter an enemy:\n"+str(enemy.typelbl.text)+"\n"+str(enemy.lvllbl.text))
		turn=1
	if resistcheck==true:
		var recdmg = enemy.damageToPlayer
		player_vars.health=int(player_vars.health)+int(recdmg)
		
		realdmg = recdmg-resistvalue
		if realdmg<0:
			textpan.text=("You resisted the attack")
			Pdmglbl.text=str(realdmg)+"\nRESISTED"
		
		else:
			player_vars.health=int(player_vars.health-realdmg)
			textpan.text=("You resisted the attack and took\n"+str(realdmg)+" damage")
			Pdmglbl.text=str(realdmg)+"\nRESISTED"
		resistvalue=0
		resistcheck=false
		pres.hide()
	
	_hide_options()
	
	health.text="Health\n"+str(player_vars.health)
	ammo.text="Ammo\n"+str(player_vars.ammo)
	rep.text="Rep\n"+str(player_vars.rep)
	money.text="Money\n$"+str(player_vars.money)
	
	print("show")
	
	currentscreen=0
	displayinv=true
	backBtn.text="Inventory"
	combatoptions.show()
	backBtn.show()
	helpBtn.show()
	
	
	
	if skipturn == true:
		skipturn=false
		pstun.hide()
		resistvalue=0
		resistcheck=false
		attacktype="Player was stunned"
		textpan.text=("You are stunned")
		todamage=0
		_enemy_turn()
		return
	

func _hide_options():
	combatoptions.hide()
	MeleeOptions.hide()
	ExitOptions.hide()
	RangeOptions.hide()
	MoveOptions.hide()
	
func _is_player_dead():
	
	if int(player_vars.health)==0:
		pstun.hide()
		_hide_options()
		backBtn.hide()
		helpBtn.hide()
		pres.hide()
		pstun.hide()
		Pdmglbl.hide()
		sprite.hide()
		isdead=true
		
		
		var playerrank = str(player_vars.rank)
		
		var playerlevel
		
		match str(playerrank):
			"Unknown":
				playerlevel=1
			"Upcoming":
				playerlevel=2
			"Felon":
				playerlevel=3
			"Crew Member":
				playerlevel=4
			"Associate":
				playerlevel=5
			"Soldier":
				playerlevel=6
			"Capo":
				playerlevel=7
			"Underboss":
				playerlevel=8
			"Consigliere":
				playerlevel=9
			"Godfather":
				playerlevel=10
			
		var punish
		
		if playerlevel-1 == enemylevel or playerlevel == enemylevel or playerlevel+1 == enemylevel:
			punish="Mid"  
		
		elif int(playerlevel)>int(enemylevel)+2:
			punish="High"
		
		else:
			punish="Low"
		
		var reptolose
		var moneytolose
		var relationtolose
		
		
		var upper
		var lower
		match str(punish):
			"High":
				lower=6
				upper=10
				relationtolose=3
			"Mid":
				lower=2
				upper=8
				relationtolose=2
			"Low":
				lower=1
				upper=4
				relationtolose=1
				
		
		PDmgPicker.randomize()	
		reptolose=PDmgPicker.randi_range(int(lower),int(upper))
		
		PDmgPicker.randomize()	
		moneytolose=PDmgPicker.randi_range(int(lower),int(upper))
		
		var repstore = player_vars.rep
		var monstore = player_vars.money
		
		player_vars.money=int(player_vars.money)-int(moneytolose)
		player_vars.rep=int(player_vars.rep)-int(reptolose)
		player_vars.CosaRep=int(player_vars.CosaRep)-int(relationtolose)
		
		if player_vars.rep < 0:
			player_vars.rep = 0
			reptolose=repstore
		
		if player_vars.money < 0:
			player_vars.money=0
			moneytolose=monstore
		
		health.text="Health\n"+str(player_vars.health)
		ammo.text="Ammo\n"+str(player_vars.ammo)
		
		rankbefore=""
		rankafter=""
		_check_rep()
		rep.text="Rep\n"+str(player_vars.rep)
		_check_rep()
		
		if str(rankbefore) != str(rankafter):
			
			dropdowntext.text=("New Rank: "+str(player_vars.rank))
			aniplayer.play("SaveDown")
			yield(aniplayer, "animation_finished")
		
		money.text="Money\n$"+str(player_vars.money)
		
		if player_vars.healContract==true or player_vars.winContract==true:
			dropdowntext.text=("Contract Failed")
			aniplayer.play("SaveDown")
			yield(aniplayer, "animation_finished")
			player_vars.contractFailed=true
			player_vars.healContract=false
			player_vars.winContract=false
			
			
	
		textpan.text=("You have been defeated.. \nYou lost: $" +str(moneytolose)+"\n"+str(reptolose)+ " Rep")
		fightlost=true
		exitBtn.text="Die?"
		turn=0
		ExitOptions.show()
		
	
func _on_Enemy_on_death():
	enemy.hplabel.hide()
	enemy.dmglbl.hide()
	enemy.lvllbl.hide()
	enemy.typelbl.hide()
	enemy.enemymeleelbl.hide()
	enemy.enemyrangelbl.hide()
	enemy.stunLbl.hide()
	enemy.resistLbl.hide()
	combatoptions.hide()
	enemy=null

func _enemy_turn():
	backBtn.hide()
	helpBtn.hide()
	_hide_options()
	
	var isdead = false
	
	if int(enemy.hplabel.text)<=0:
		enemy.hplabel.hide()
		enemy.dmglbl.hide()
		enemy.lvllbl.hide()
		enemy.typelbl.hide()
		enemy.enemymeleelbl.hide()
		enemy.enemyrangelbl.hide()
		enemy.stunLbl.hide()
		enemy.resistLbl.hide()
		enemy.hplabel.text="HP: 0"
		
	yield(get_tree().create_timer(1),"timeout")
	if enemy==null:
		isdead=true
	if isdead == false:
		enemy._enemy_turn_enemy()
		var attacktype = str(enemy.attacktype)
		var damagetaken = str(enemy.damageToPlayer)
		if enemy.attacktype=="Enemy was stunned":
			textpan.text="Enemy is stunned"
		elif enemy.attacktype=="Dodge":
			textpan.text="Enemy used Dodge"
		else:	
			textpan.text=("Enemy used: "+attacktype+"\nIt hit for: "+damagetaken)
			Pdmglbl.text=(str(damagetaken))
			Pdmglbl.show()
			if resistcheck==true:
				print(str(realdmg))
				if (realdmg==null):
					pass
				elif realdmg<=0:
					Pdmglbl.text=("RESISTED")
				else:
					Pdmglbl.text=(str(realdmg)+"\nRESISTED")
			
			if enemy.miss==true:
				textpan.text=("Enemy used: "+attacktype+"\nBut it MISSED.")
				Pdmglbl.text=("MISS")
			else:
				playerani.play("RecDmg")
				
			PDmgPicker.randomize()
			var numbani=PDmgPicker.randi_range(1,2)
			
			match int(numbani):
				1:
					playerani.play("PDmg1")
					yield(playerani, "animation_finished")
					Pdmglbl.hide()
				2:
					playerani.play("PDmg2")
					yield(playerani, "animation_finished")
					Pdmglbl.hide()
		
		yield(get_tree().create_timer(1.0),"timeout")
		
		_ready()
	
	elif isdead == true:
		var gain
		var playerrank = str(player_vars.rank)
		
		var playerlevel
		
		match str(playerrank):
			"Unknown":
				playerlevel=1
			"Upcoming":
				playerlevel=2
			"Felon":
				playerlevel=3
			"Crew Member":
				playerlevel=4
			"Associate":
				playerlevel=5
			"Soldier":
				playerlevel=6
			"Capo":
				playerlevel=7
			"Underboss":
				playerlevel=8
			"Consigliere":
				playerlevel=9
			"Godfather":
				playerlevel=10
		
		if enemylevel-1 == playerlevel or playerlevel == enemylevel or enemylevel+1 == playerlevel:
			gain="Mid"  
		
		elif int(enemylevel)>int(playerlevel)+2:
			gain="High"
		
		else:
			gain="Low"
		
		var reptogain
		var moneytogain
		var relationtolose
		
		
		var upper
		var lower
		match str(gain):
			"High":
				lower=6
				upper=10
				relationtolose=3
			"Mid":
				lower=2
				upper=8
				relationtolose=2
			"Low":
				lower=1
				upper=4
				relationtolose=1
				
		
		PDmgPicker.randomize()	
		reptogain=PDmgPicker.randi_range(int(lower),int(upper))
		
		PDmgPicker.randomize()	
		moneytogain=PDmgPicker.randi_range(int(lower),int(upper))
		
		
		
		player_vars.money=int(player_vars.money)+int(moneytogain)
		
		rankbefore=""
		rankafter=""
		_check_rep()
		player_vars.rep=int(player_vars.rep)+int(reptogain)
		_check_rep()
		
		if str(rankbefore) != str(rankafter):
			
			dropdowntext.text=("New Rank: "+str(player_vars.rank))
			print("Rank up ani")
			aniplayer.play("SaveDown")
			yield(aniplayer, "animation_finished")
			
		player_vars.PavRep=int(player_vars.PavRep)+int(relationtolose)
		player_vars.CosaRep=int(player_vars.CosaRep)-int(relationtolose)
		
		
		var activecont = 0
		
		if player_vars.bruteContract==true:
			activecont = 1
			player_vars.bruteContractCount=int(player_vars.bruteContractCount)+1
			dropdowntext.text=("Brute Killed: "+str(player_vars.bruteContractCount)+"/5")
			if player_vars.bruteContractCount>=5:
				player_vars.bruteContractCount=5
				dropdowntext.text=("Contract Completed")
				
		elif player_vars.healContract==true:
			activecont = 1
			player_vars.healContractCount=int(player_vars.healContractCount)+1
			dropdowntext.text=("Fights won: "+str(player_vars.healContractCount)+"/5")
			
			if player_vars.healContractCount>=5:
				player_vars.healContractCount=5
				dropdowntext.text=("Contract Completed")
				
		elif player_vars.winContract==true:
			activecont = 1
			player_vars.winContractCount=int(player_vars.winContractCount)+1
			dropdowntext.text=("Fights won: "+str(player_vars.winContractCount)+"/8")
			
			if player_vars.winContractCount>=8:
				player_vars.winContractCount=8
				dropdowntext.text=("Contract Completed")
		
		if activecont == 1:
			aniplayer.play("SaveDown")
			yield(aniplayer, "animation_finished")
			activecont=0
		
		health.text="Health\n"+str(player_vars.health)
		ammo.text="Ammo\n"+str(player_vars.ammo)
		rep.text="Rep\n"+str(player_vars.rep)
		money.text="Money\n$"+str(player_vars.money)
		
		textpan.text=("You Won! \nYou gained:\n$" +str(moneytogain)+"\n"+str(reptogain)+ " Rep")
		exitBtn.text="Leave"
		turn=0
		ExitOptions.show()
		
		


func _on_Button2_pressed():
	aniplayer2.play("FADE4")
	yield(aniplayer2, "animation_finished")
	if fightlost==false:
		get_tree().change_scene("res://UI_LItalyMap.tscn")
	else:
		get_tree().change_scene("res://UI_Map.tscn")
	

func _on_MeleeOBtn_pressed():
	_hide_options()
	MeleeOptions.show()
	displayinv=false
	backBtn.text="Back"
	currentscreen=1


func _on_RangeOBtn_pressed():
	_hide_options()
	RangeOptions.show()
	displayinv=false
	backBtn.text="Back"
	currentscreen=2


func _on_MovementOBtn_pressed():
	_hide_options()
	MoveOptions.show()
	displayinv=false
	backBtn.text="Back"
	currentscreen=3


func _on_BackBtn_pressed():
	if panOpen==true:
		helpPanel.hide()
		print("hide help")
		panOpen=false
		if currentscreen==0:
			backBtn.text="Inventory"
		
	elif currentscreen==0:
		invopen=true
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
		invopen=false
		
	elif currentscreen !=0:
		currentscreen=0
		_hide_options()
		backBtn.text="Inventory"
		combatoptions.show()


func _on_HelpBtn_pressed():
	if panOpen==true:
		panOpen=false
		helpPanel.hide()
		return
		
	panOpen = true
	helpPanel.show()
	print("show help")
	
	if currentscreen==0:
		backBtn.text="Back"
		helpPanTitle.text="Combat Help:"
		helpPanCont.text="\n\nMelee:\n\nDeal a melee attack using your\nequip melee weapon\n\n\nRanged:\n\nUse your ranged weapon to\nattack the enemy\n(requires ammo)\n\n\nMovement:\n\nUse a movement to apply\ndebuffs and buffs\n(or try run away)"
		
	elif currentscreen==1:
		helpPanTitle.text="Melee Help:"
		helpPanCont.text="\n\nQuick Strike:\n\nDeal a quick strike\nDMG: "+str(player_vars.equipMeleeDmgMin)+"-"+str(player_vars.equipMeleeDmgMax)+"\n100% Acc\n\n\nHeavy Smash:\n\nDeliever a heavy smash\nDMG: "+str(player_vars.equipMeleeDmgMin)+"-"+str(player_vars.equipMeleeDmgMax)+" + 2\n75% Acc\n\n\nBurst Attack:\n\nApply a trio of attacks\nDMG: 3 x "+str(player_vars.equipMeleeDmgMin)+"-"+str(player_vars.equipMeleeDmgMax)+"\n60% Acc"
		
	elif currentscreen==2:
		helpPanTitle.text="Ranged Help:"
		helpPanCont.text="\nPrecision Shot(1):\n\nDeal a focused aimed shot\nDMG: "+str(player_vars.equipRangeDmgMin)+"-"+str(player_vars.equipRangeDmgMax)+" +25% crit\n80% Acc\nMiss next turn\n\n\nCovered Shot(1):\n\nDive for cover and fire a shot\nDMG: "+str(player_vars.equipRangeDmgMin)+"-"+str(player_vars.equipRangeDmgMax)+"\n+resist equal to damage\n75% Acc\n\n\nDual Shot(2):\n\nFire 2 rounds at the enemy\nDMG: 2 x "+str(player_vars.equipRangeDmgMin)+"-"+str(player_vars.equipRangeDmgMax)+"\n75% Acc"
		
	elif currentscreen==3:
		helpPanTitle.text="Movement Help:"
		helpPanCont.text="\n\nDodge:\n\nDodge to gain damage\nresistance\nRes: "+str(player_vars.equipMeleeDmgMin)+"-"+str(player_vars.equipMeleeDmgMax)+"+5\n100% Acc\n\n\nTrip:\n\nTrip the enemy to interupt their\nturn\nDMG: Stun\n75% Acc\n\n\nFlee:\n\nAttempt to run from combat\nFlee chance: "+str(fleechance)+"%"
		
	

func _on_QMeleeBtn_pressed():
	miss = false
	PDmgPicker.randomize()
	PCritPicker.randomize()
	
	todamage = 0
	iscrit = false
	
	critcheck = 0
	todamage = PDmgPicker.randi_range(int(playerMeleeMinDmg),int(playerMeleeMaxDmg))
	
	critcheck=PCritPicker.randi_range(0,100)
	
	if critcheck <= int(playerMeleeCrit):
		iscrit=true
		
	
	
	if enemy !=null:
		attacktype="Quick Attack"
		_apply_dmg_to_enemy()
		


func _on_HMeleeBtn_pressed():
	miss = false
	iscrit = false
	
	PDmgPicker.randomize()
	todamage = int(PDmgPicker.randi_range(int(playerMeleeMinDmg),int(playerMeleeMaxDmg)))
	todamage = todamage+2
	
	
	PDmgPicker.randomize()
	critcheck = int(PDmgPicker.randi_range(0,100))
	if (critcheck<=int(playerMeleeCrit)):
		iscrit=true
	
	
	PDmgPicker.randomize()
	misschance = 75
	if (int(PDmgPicker.randi_range(0,100))>misschance):
		print("miss")
		miss=true
		
	if enemy !=null:
		attacktype="Heavy Attack"
		_apply_dmg_to_enemy()

func _on_BMeleeBtn_pressed():
	accadmg=0
	miss = false
	iscrit = false
	var critchance
	
	PDmgPicker.randomize()
	misschance = 60
	if (int(PDmgPicker.randi_range(0,100))>misschance):
		print("miss")
		miss=true
	
	
	var count = 0
	todamage=0
	
	
	accadmg=0
	print("burst start")
	PDmgPicker.randomize()
	accadmg = int(PDmgPicker.randi_range(int(playerMeleeMinDmg),int(playerMeleeMaxDmg)))
	print (accadmg)
	PDmgPicker.randomize()
	accadmg = accadmg+int(PDmgPicker.randi_range(int(playerMeleeMinDmg),int(playerMeleeMaxDmg)))
	print (accadmg)
	PDmgPicker.randomize()
	accadmg = accadmg+int(PDmgPicker.randi_range(int(playerMeleeMinDmg),int(playerMeleeMaxDmg)))
	print (accadmg)
	print("burst end")
	
	PDmgPicker.randomize()
	
	critchance = int(PDmgPicker.randi_range(0,100))
	print(critchance)
	if (critchance<=int(playerRangeCrit)):
		print("crit")
		iscrit=true
	
	pstun.show()
	skipturn=true
	todamage=accadmg
	
	attacktype="Burst Attack"
	_apply_dmg_to_enemy()

func _on_PSBtn_pressed():
	var ammocount = int(ammo.text)
	
	if ammocount >= 1 && int(playerRangeMaxDmg)>0:
		player_vars.ammo=int(player_vars.ammo)-1
		miss = false
		iscrit = false
	
		PDmgPicker.randomize()
		todamage = int(PDmgPicker.randi_range(int(playerRangeMinDmg),int(playerRangeMaxDmg)))
	
	
		PDmgPicker.randomize()
		var critchance
		critchance = int(PDmgPicker.randi_range(0,100))
		playerRangeCrit=playerRangeCrit+25
		print(critchance)
		if (critchance<=int(playerRangeCrit)):
			print("crit")
			iscrit=true
	
		playerRangeCrit=playerRangeCrit-25
	
		PDmgPicker.randomize()
		misschance = 80
		if (int(PDmgPicker.randi_range(0,100))>misschance):
			print("miss")
			miss=true
		
		pstun.show()
		skipturn=true
		attacktype="Precision Shot"
		_apply_dmg_to_enemy()
			
	else:	
		textpan.text=("no ammo\nor no ranged weapon")


func _on_CSBtn_pressed():
	var ammocount = int(ammo.text)
	
	if ammocount >= 1 && int(playerRangeMaxDmg)>0:
		player_vars.ammo=int(player_vars.ammo)-1
		miss = false
		iscrit = false
	
		PDmgPicker.randomize()
		todamage = int(PDmgPicker.randi_range(int(playerRangeMinDmg),int(playerRangeMaxDmg)))
	
	
		PDmgPicker.randomize()
		var critchance
		critchance = int(PDmgPicker.randi_range(0,100))
		print(critchance)
		if (critchance<=int(playerRangeCrit)):
			print("crit")
			iscrit=true
	
	
		PDmgPicker.randomize()
		misschance = 75
		if (int(PDmgPicker.randi_range(0,100))>misschance):
			print("miss")
			miss=true
		
		resistcheck=true
		resistvalue=todamage+2
		pres.text="R: "+str(resistvalue)
		pres.show()
		
		#show resist label for player here?
		
		if resistvalue == 0:
			resistcheck=false
		
	
		attacktype="Cover Shot"
		_apply_dmg_to_enemy()
			
	else:	
		textpan.text=("no ammo\nor no ranged weapon")


func _on_DSBtn_pressed():
	var ammocount = int(ammo.text)
	
	if ammocount >= 2 && int(playerRangeMaxDmg)>0:
		player_vars.ammo=int(player_vars.ammo)-2
		miss = false
		iscrit = false
	
		PDmgPicker.randomize()
		todamage = int(PDmgPicker.randi_range(int(playerRangeMinDmg),int(playerRangeMaxDmg)))
		PDmgPicker.randomize()
		todamage = todamage+int(PDmgPicker.randi_range(int(playerRangeMinDmg),int(playerRangeMaxDmg)))
	
	
		PDmgPicker.randomize()
		var critchance
		critchance = int(PDmgPicker.randi_range(0,100))
		print(critchance)
		if (critchance<=int(playerRangeCrit)):
			print("crit")
			iscrit=true
	
	
		PDmgPicker.randomize()
		misschance = 75
		if (int(PDmgPicker.randi_range(0,100))>misschance):
			print("miss")
			miss=true
		
		attacktype="Dual Shot"
		_apply_dmg_to_enemy()
			
	else:	
		textpan.text=("no ammo\nor no ranged weapon")


func _on_DodgeBtn_pressed():
	ismovement=true
	miss = false
	iscrit = false
	
	PDmgPicker.randomize()
	todamage = int(PDmgPicker.randi_range(int(playerMeleeMinDmg),int(playerMeleeMaxDmg)))
	
	
	PDmgPicker.randomize()
	critcheck = int(PDmgPicker.randi_range(0,100))
	if (critcheck<=int(playerMeleeCrit)):
		todamage=todamage*2
		
	todamage=todamage+5
	resistcheck=true
	resistvalue=todamage
	
	pres.text="R: "+str(resistvalue)
	pres.show()
	
	attacktype="Dodge"
	
	todamage=0
	
	if enemy !=null:
		attacktype="Dodge"
		_apply_dmg_to_enemy()


func _on_TripBtn_pressed():
	ismovement=true
	miss = false
	iscrit=false
	todamage = 0
	PDmgPicker.randomize()
	var tripcheck = 0
	tripcheck = int(PDmgPicker.randi_range(0,3))
	
	attacktype="Trip"
	if tripcheck != 3:
		enemy.skipturn=true
		enemy.stunLbl.show()
	
	else:
		attacktype="Trip FAILED"
	
	_apply_dmg_to_enemy()


func _apply_dmg_to_enemy():
	if iscrit==true:
		todamage = todamage*2
		textpan.text=("You Used: "+str(attacktype)+"\nIt CRIT for: "+str(todamage))
	else:
		textpan.text=("You Used: "+str(attacktype)+"\nIt hit for: "+str(todamage))
		
	if miss == true:
		todamage=0
		textpan.text=("You Used: "+str(attacktype)+"\nand it missed")
			
	
			
	
		
	enemy.dmglblvalue = todamage
	if miss==true:
		player_vars.miss=true
		
	if ismovement==true:
		textpan.text=("You Used: "+str(attacktype))
		enemy.dmglbl.hide()
		player_vars.movement=true
	else:
		playerani.play("DealDmg")
		yield(playerani, "animation_finished")
		
	enemy.dmglbl.show()
	enemy.hp -= todamage
	_hide_options()
	backBtn.hide()
	helpBtn.hide()
	yield(get_tree().create_timer(0.7),"timeout")
	_enemy_turn()



signal But2press

func _on_FleeBtn_pressed():
	miss = false
	iscrit = false
	todamage = 0
	
	var fleecheck
	
	PDmgPicker.randomize()
	if fleechance>=int(PDmgPicker.randi_range(0,100)):
		textpan.text=("You attempt to flee... \nIt was successful")
		print("flee successful")
		_hide_options()
		enemy.hide()
		exitBtn.text="Run away"
		flee=true
		backBtn.hide()
		helpBtn.hide()
		
		health.text="Health\n"+str(player_vars.health)
		ammo.text="Ammo\n"+str(player_vars.ammo)
		rep.text="Rep\n"+str(player_vars.rep)
		money.text="Money\n$"+str(player_vars.money)
		
		ExitOptions.show()
		print("the end?")
		
	
		
	else:
		print("flee unsuccessful")
		textpan.text=("You attempt to flee... \nIt failed")
		_enemy_turn()

func _check_rep():
	var checkrep=int(player_vars.rep)
	
	if str(rankbefore)=="":
		rankbefore=str(player_vars.rank)
		
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
	
	rankafter=str(player_vars.rank)


extends Node2D

var hp = 10 setget set_hp
var dmglblvalue = 0 setget set_dmglblval

onready var player_vars = get_node("/root/PlayerVariables")

onready var enemyH = $Enemy
onready var hplabel = $HPLabel
onready var dmglbl = $EnemyDmgLbl
onready var lvllbl = $LvlLabel1
onready var animooplayer =$AnimationPlayer
onready var dmglblani = $AnimationPlayer2
onready var typelbl = $TypeLbl
onready var withrangepnl = $WithRangedPnl
onready var withoutrangepnl =$NoRangedPnl
onready var enemymeleelbl = $EnemyMeleeLbl
onready var enemyrangelbl= $EnemyRangeLbl
onready var stunLbl = $StunLbl
onready var resistLbl = $ResistLbl
onready var godpnl = $GodPnl

onready var enemysprite = $Sprite

var godcombat
var region = ""

var EnemyLvlPicker = RandomNumberGenerator.new()
var EnemyTypePicker = RandomNumberGenerator.new()
var DamageRandom = RandomNumberGenerator.new()

var EnemyType

var EMeleeWeap
var EMeleeMinDmg
var EMeleeMaxDmg 
var EMeleeCrit
var animationtoplay
var ERangeWeap
var ERangeMinDmg
var ERangeMaxDmg 
var ERangeCrit

signal on_death

var damageToPlayer
var enemycrit
var critchance
var miss
var misschance
var attacktype
var accadmg
var skipturn

var resistcheck
var resistvalue
var playerranker

func _ready():
	animationtoplay="dmgValAni"
	animooplayer.play("Idle")
	print("enemy is ready")
	
	var playerRank = str(player_vars.rank)

	var enemylvlupper = 0
	var enemylvllower = 0
	
	playerranker = 0
	
	if playerRank=="Unknown" or playerRank=="Upcoming" or playerRank=="Felon":
		playerranker = 1
		
	if playerRank=="Crew Member" or playerRank=="Associate":
		playerranker = 2
	
	if playerRank=="Solider" or playerRank=="Capo":
		playerranker = 3
	
	if playerRank == "Underboss" or playerRank== "Consigliere":
		playerranker = 4
	
	if playerRank=="Godfather":
		playerranker = 5
	
	if (get_tree().get_current_scene().get_name()=="GodCombat"):
		playerranker = 5
		godcombat=true
	else:
		godcombat=false
		
	match playerranker:
		1:
			enemylvllower = 5
			enemylvlupper = 1
		2:
			enemylvllower = 3
			enemylvlupper = 8
		3:
			enemylvllower = 5
			enemylvlupper = 10
		4:
			enemylvllower = 8
			enemylvlupper = 12
		5:
			enemylvllower = 15
			enemylvlupper = 15
	
	EnemyLvlPicker.randomize()
	var enemyLvl = 0 
	enemyLvl = EnemyLvlPicker.randi_range(int(enemylvllower),int(enemylvlupper))
	lvllbl.text = "Lvl: "+str(enemyLvl)
	
	EnemyTypePicker.randomize()
	var enemytype = 0
	enemytype=EnemyTypePicker.randi_range(0,3)
	
	if godcombat==true:
		enemytype=4
		
	EnemyTypePicker.randomize()
	var enemymelee = int(EnemyTypePicker.randi_range(0,3))
	
	EnemyTypePicker.randomize()
	var enemyrange = int(EnemyTypePicker.randi_range(0,1))
	
	var meleeweps=["Fists","Dusters","Bat","Knife"]
	var meleedmgmin=[0,1,1,3]
	var meleedmgmax=[2,3,7,6]
	var meleecrit=[10,12,5,10]
	
	var rangeweps=["None","Pistol","Rifle"]
	var rangedmgmin=[0,2,3]
	var rangedmgmax=[0,5,10]
	var rangecrit=[0,8,15]
	
	print ("melee: "+str(enemymelee))
	print ("ranged: "+str(enemyrange))
	
	var path=get_tree().get_current_scene().get_name()
	
	if str(path) == "LICombat":
		region="LI"
	elif str(path) == "HarCombat":
		region="HAR"
	elif str(path) == "UECombat":
		region="UE"
	elif str(path) == "LECombat":
		region="LE"
		
	match enemytype:
		0:
			match str(region):
				"LI":
					enemysprite.texture = load("res://Assets/CosaBrute.png")
				"HAR":
					enemysprite.texture = load("res://Assets/HarlemBrute.png")
				"LE":
					enemysprite.texture = load("res://Assets/PaveeBrute.png")
				"UE":
					enemysprite.texture = load("res://Assets/UndzBrute.png")
			EnemyType="Brute"
			typelbl.text="Brute"
			hp = enemyLvl*5
			enemyrange=0
			if enemymelee+1 == int(meleeweps.size()):
				enemymelee=meleeweps.size()-1
			else:
				enemymelee=enemymelee+1
		1:
			match str(region):
				"LI":
					enemysprite.texture = load("res://Assets/CosaMob.png")
				"HAR":
					enemysprite.texture = load("res://Assets/HarlemMob.png")
				"LE":
					enemysprite.texture = load("res://Assets/PaveeMob.png")
				"UE":
					enemysprite.texture = load("res://Assets/UndzMob.png")
			EnemyType="Mobster"
			typelbl.text="Mobster"
			hp = enemyLvl*4
		2:
			match str(region):
				"LI":
					enemysprite.texture = load("res://Assets/CosaBrute.png")
				"HAR":
					enemysprite.texture = load("res://Assets/HarlemBrute.png")
				"LE":
					enemysprite.texture = load("res://Assets/PaveeBrute.png")
				"UE":
					enemysprite.texture = load("res://Assets/UndzBrute.png")
			EnemyType="Jerk"
			typelbl.text="Jerk"
			hp = enemyLvl*3
			enemyrange=0
		3:
			match str(region):
				"LI":
					enemysprite.texture = load("res://Assets/CosaMob.png")
				"HAR":
					enemysprite.texture = load("res://Assets/HarlemMob.png")
				"LE":
					enemysprite.texture = load("res://Assets/PaveeMob.png")
				"UE":
					enemysprite.texture = load("res://Assets/UndzMob.png")
			EnemyType="Crook"
			typelbl.text="Crook"
			if enemyrange==0:
				enemyrange=1
			hp = enemyLvl*2
		
		4:
			enemysprite.texture = load("res://Assets/Godfather.png") 
			EnemyType="Godfather"
			typelbl.text="Godfather"
			enemyrange=1
			hp = 50
	
	
	print ("melee: "+str(enemymelee))
	print ("ranged: "+str(enemyrange))
	
	if str(EnemyType)=="Godfather":
		EMeleeWeap = "God Fist"
		EMeleeMinDmg = 10
		EMeleeMaxDmg = 20
		EMeleeCrit = 10
		
		ERangeWeap = "God Gun"
		ERangeMinDmg = 15
		ERangeMaxDmg = 25
		ERangeCrit = 10
	else:
		EMeleeWeap = str(meleeweps[enemymelee])
		EMeleeMinDmg = int(meleedmgmin[enemymelee])
		EMeleeMaxDmg = int(meleedmgmax[enemymelee])
		EMeleeCrit = int(meleecrit[enemymelee])
		
		ERangeWeap = str(rangeweps[enemyrange])
		ERangeMinDmg = int(rangedmgmin[enemyrange])
		ERangeMaxDmg = int(rangedmgmax[enemyrange])
		ERangeCrit = int(rangecrit[enemyrange])
	
	hplabel.text= "Hp: "+ str(hp)
	enemymeleelbl.text=str(meleeweps[enemymelee])
	enemyrangelbl.text=str(rangeweps[enemyrange])
	
		
	
	if enemyrange==0:
		enemyrangelbl.text=""
		withoutrangepnl.show()
	else:
		if godcombat==true:
			godpnl.show()
		else:
			withrangepnl.show()
	
	
func _enemy_turn_enemy(): #enemy turn method
	animooplayer.play("Idle") #plays enemy idle animation
	
	if skipturn == true: #checks if enemy is meant to skup the turn
		stunLbl.hide() #hides stun label
		skipturn=false #sets skipturn value to false
		resistvalue=0 #sets resist value to 0
		resistcheck=false #sets resist check to false
		resistLbl.hide() #hides resist label
		attacktype="Enemy was stunned" #sets attack type
		damageToPlayer=0 #sets damage to 0
		return #ends method process 
	
	if resistcheck==true: #checks if enemy has resist set
		resistLbl.hide() #hides resist label
		resistvalue=0 #sets resist value to 0
		resistcheck=false #sets check to false
	
	var rangedequip = false #creates and sets ranged equip to false
	var totalactions = 4 #creates and sets totalactions to 4
	
	DamageRandom.randomize() #randomize value or damagerandom
	var actiontotake 
	
	match str(EnemyType): #matches enemy type to generated enemy
		"Brute":
			print("Brute")
			
		"Mobster":
			print("Mob")
			if enemyrangelbl.text!="": #checks if enemy has ranged item 
				totalactions=7 #sets total actions to 7
				rangedequip=true #sets ranged equip to be true
				print(str(rangedequip))
			
		"Jerk":
			print("Jerk")
			
		"Crook": 
			totalactions=7#sets total actions to 7 to include ranged attacks
			print("Crook")
			
			
	actiontotake = int(DamageRandom.randi_range(1,totalactions)) #randomly decides an action to take by generating a random number
	
	match int(actiontotake): #matches random generated number to a action method
		1:
			_enemy_Q_Melee() #runs quick attack method
		2:
			_enemy_H_Melee() #runs heavy attack method
		3:
			_enemy_B_Melee() #runs burst attack method
		4:
			_enemy_D_move() #runs dodge method 
		5:
			_enemy_PS_range() #runs precision shot method
		6:
			_enemy_CS_range() #runs covered shot method
		7: 
			_enemy_DS_range() #runs dual shot method
	
	
func _enemy_Q_Melee():
	miss = false
	enemycrit = false
	
	DamageRandom.randomize()
	damageToPlayer = int(DamageRandom.randi_range(EMeleeMinDmg,EMeleeMaxDmg))
	
	
	DamageRandom.randomize()
	critchance = int(DamageRandom.randi_range(0,100))
	print(critchance)
	if (critchance<=EMeleeCrit):
		print("crit")
		enemycrit=true
	
	attacktype="Light Attack"
	_apply_damage()


func _enemy_H_Melee():
	miss = false
	enemycrit = false
	
	DamageRandom.randomize()
	damageToPlayer = int(DamageRandom.randi_range(EMeleeMinDmg,EMeleeMaxDmg))
	damageToPlayer = damageToPlayer+2
	
	
	DamageRandom.randomize()
	critchance = int(DamageRandom.randi_range(0,100))
	print(critchance)
	if (critchance<=EMeleeCrit):
		print("crit")
		enemycrit=true
	
	
	DamageRandom.randomize()
	misschance = 75
	if (int(DamageRandom.randi_range(0,100))>misschance):
		print("miss")
		miss=true
		
	attacktype="Heavy Attack"
	_apply_damage()

func _enemy_B_Melee():
	accadmg=0
	miss = false
	enemycrit = false
	
	DamageRandom.randomize()
	misschance = 60
	if (int(DamageRandom.randi_range(0,100))>misschance):
		print("miss")
		miss=true
	
	
	var count = 0
	damageToPlayer=0

	accadmg=0
	print("burst start")
	DamageRandom.randomize()
	accadmg = int(DamageRandom.randi_range(EMeleeMinDmg,EMeleeMaxDmg))
	print (accadmg)
	DamageRandom.randomize()
	accadmg = accadmg+int(DamageRandom.randi_range(EMeleeMinDmg,EMeleeMaxDmg))
	print (accadmg)
	DamageRandom.randomize()
	accadmg = accadmg+int(DamageRandom.randi_range(EMeleeMinDmg,EMeleeMaxDmg))
	print (accadmg)
	print("burst end")
	damageToPlayer=accadmg
		
		
	stunLbl.show()
	skipturn=true
			
	DamageRandom.randomize()
	critchance = int(DamageRandom.randi_range(0,100))
	if (critchance<=EMeleeCrit):
		print("crit")
		enemycrit=true
		
	attacktype="Burst Attack"
	_apply_damage()

func _enemy_PS_range():
	miss = false
	enemycrit = false
	
	DamageRandom.randomize()
	damageToPlayer = int(DamageRandom.randi_range(ERangeMinDmg,ERangeMaxDmg))
	
	
	DamageRandom.randomize()
	critchance = int(DamageRandom.randi_range(0,100))
	ERangeCrit=ERangeCrit+25
	print(critchance)
	if (critchance<=ERangeCrit):
		print("crit")
		enemycrit=true
	
	ERangeCrit=ERangeCrit-25
	DamageRandom.randomize()
	misschance = 80
	if (int(DamageRandom.randi_range(0,100))>misschance):
		print("miss")
		miss=true
		
	skipturn=true
	stunLbl.show()
	attacktype="Precision Shot"
	_apply_damage()
	
func _enemy_CS_range():
	miss = false
	enemycrit = false
	
	DamageRandom.randomize()
	damageToPlayer = int(DamageRandom.randi_range(ERangeMinDmg,ERangeMaxDmg))
	
	
	DamageRandom.randomize()
	critchance = int(DamageRandom.randi_range(0,100))
	print(critchance)
	if (critchance<=ERangeCrit):
		print("crit")
		enemycrit=true
	
	resistcheck=true
	resistvalue=damageToPlayer+2
	
	resistLbl.text="R: "+str(resistvalue)
	resistLbl.show()
	
	if resistvalue == 0:
		resistcheck=false
		resistLbl.hide()
		
	DamageRandom.randomize()
	misschance = 75
	if (int(DamageRandom.randi_range(0,100))>misschance):
		print("miss")
		miss=true
		
	
	attacktype="Covered Shot"
	_apply_damage()
	
	
func _enemy_DS_range():
	miss = false
	enemycrit = false
	
	DamageRandom.randomize()
	damageToPlayer = int(DamageRandom.randi_range(ERangeMinDmg,ERangeMaxDmg))
	DamageRandom.randomize()
	damageToPlayer = damageToPlayer + int(DamageRandom.randi_range(ERangeMinDmg,ERangeMaxDmg))
	
	
	DamageRandom.randomize()
	critchance = int(DamageRandom.randi_range(0,100))
	print(critchance)
	if (critchance<=ERangeCrit):
		print("crit")
		enemycrit=true
	
	DamageRandom.randomize()
	misschance = 75
	if (int(DamageRandom.randi_range(0,100))>misschance):
		print("miss")
		miss=true
	
	attacktype="Dual Shot"
	_apply_damage()

func _enemy_D_move():
	enemycrit = false
	
	DamageRandom.randomize()
	damageToPlayer = int(DamageRandom.randi_range(EMeleeMinDmg,EMeleeMaxDmg))
	
	
	DamageRandom.randomize()
	critchance = int(DamageRandom.randi_range(0,100))
	print(critchance)
	if (critchance<=EMeleeCrit):
		print("crit")
		enemycrit=true
	
	if enemycrit==true:
		damageToPlayer=damageToPlayer*2
	
	damageToPlayer=damageToPlayer+5
	resistcheck=true
	resistvalue=damageToPlayer
	resistLbl.text="R: "+str(resistvalue)
	resistLbl.show()
	
	attacktype="Dodge"
	damageToPlayer=0
	_apply_damage()
	
func _enemy_T_move():
	pass
func _enemy_F_move():
	pass

func _apply_damage():
	
	if (enemycrit==true):
		damageToPlayer=damageToPlayer*2
	if miss==false:
		animooplayer.play("Attack")
		yield(animooplayer, "animation_finished")
		player_vars.health=int(player_vars.health)-int(damageToPlayer)
		if player_vars.health<0:
			player_vars.health=0
					
	else:
		damageToPlayer=0
		animooplayer.play("Attack")
		yield(animooplayer, "animation_finished")
	
	animooplayer.play("Idle")	

func set_dmglblval(new_dmglblval):
	dmglblvalue=new_dmglblval

func set_hp(new_hp):
	
	if resistcheck==true:
		if dmglblvalue<=resistvalue:
			dmglblvalue=0
		else:
			dmglblvalue=dmglblvalue-resistvalue
			hp=hp-dmglblvalue
	else:
		hp=new_hp
	
	_decide_ani_()
	dmglbl.text=str(dmglblvalue)
	hplabel.text= "Hp: "+ str(hp)
	if hp<=0:
		animooplayer.play("dead")
		withoutrangepnl.hide()
		withrangepnl.hide()
		godpnl.hide()
		hplabel.hide()
		dmglbl.hide()
		lvllbl.hide()
		typelbl.hide()
		enemymeleelbl.hide()
		enemyrangelbl.hide()
		stunLbl.hide()
		resistLbl.hide()
		
		
		enemyH=null
		yield(animooplayer,"animation_finished")
		emit_signal("on_death")
		
		queue_free()
	elif int(dmglblvalue==0):
		
		if player_vars.movement==true:
			player_vars.movement=false
			dmglbl.hide()
			dmglblani.play(animationtoplay)
		
		elif player_vars.miss==true:
			player_vars.miss=false
			dmglbl.text="MISS"
			dmglblani.play(animationtoplay)
		
		elif resistcheck==true:
			dmglbl.text=str(dmglbl.text)+"\nRESISTED"
			dmglblani.play(animationtoplay)
		
		else:
			dmglblani.play(animationtoplay)
		
		yield(dmglblani, "animation_finished")
		dmglbl.text=""
		dmglbl.show()
	else:
		animooplayer.play("TakeDmg")
		
		if resistcheck==true:
			dmglbl.text=str(dmglbl.text)+"\nRESISTED"
			dmglblani.play(animationtoplay)
		else:
			dmglblani.play(animationtoplay)
			
		yield(animooplayer, "animation_finished") 
		dmglbl.text=""

func _decide_ani_():
	var numb = 2
	DamageRandom.randomize()
	var anitodo = int(DamageRandom.randi_range(0,numb))
	
	match anitodo:
		0:
			animationtoplay="dmgValAni"
		1:
			animationtoplay="dmgValAni2"
		2:
			animationtoplay="dmgValAni3"

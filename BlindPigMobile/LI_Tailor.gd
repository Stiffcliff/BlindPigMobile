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

onready var unknownContainer = $UnknownContainer
onready var upcomingContainer = $UpcomingContainer
onready var felonContainer = $FelonContainer
onready var crewmemberContainer = $CrewMemberContainer
onready var associateContainer = $AssociateContainer
onready var soldierContainer = $SoldierContainer
onready var capoContainer = $CapoContainer
onready var underbossContainer = $UnderbossContainer
onready var consigliereContainer = $ConsigliereContainer
onready var godfatherContainer = $GodfatherContainer

onready var itemimage = $GraphicsPanel/ItemPanel/ItemImage
onready var itemeffect = $GraphicsPanel/DescPanel/EffectPanel
onready var buyorno = $BuyOrNo

onready var uhandbtn = $UnknownContainer/UHandBtn
onready var csusbtn = $UnknownContainer/CSusBtn

onready var oldshirtbtn = $UpcomingContainer/OldShirtBtn
onready var streetcapbtn = $UpcomingContainer/StreetCapBtn
onready var cheapcanebtn = $UpcomingContainer/CheapCaneBtn

onready var oldsockbtn = $FelonContainer/OSockBtn
onready var oldwaistcoatbtn = $FelonContainer/OWcoatBtn
onready var oldshoesbtn = $FelonContainer/OShoeBtn

onready var oldtiebtn = $CrewMemberContainer/OTieBtn
onready var oldpantsbtn = $CrewMemberContainer/OPantsBtn
onready var oldsuitjacketbtn = $CrewMemberContainer/OSJacketBtn

onready var oldcoatbtn = $AssociateContainer/OCoatBtn
onready var silkpocketsquarebtn = $AssociateContainer/SPocketBtn
onready var classsusbtn = $AssociateContainer/ClassSusBtn

onready var itshirtbtn = $SoldierContainer/ItShirtBtn
onready var oakcanebtn = $SoldierContainer/OakCaneBtn
onready var itpantbtn = $SoldierContainer/ItPantBtn

onready var itwcoatbtn = $CapoContainer/ItWCoatBtn
onready var itshoesbtn = $CapoContainer/ItShoesBtn
onready var itsjacketbtn = $CapoContainer/ItSJacketBtn

onready var silktiebbtn = $UnderbossContainer/STieBtn
onready var itcoatbtn = $UnderbossContainer/ItCoatBtn
onready var goldsusbtn = $UnderbossContainer/GSusBtn

onready var ivorycanebtn = $ConsigliereContainer/ICaneBtn
onready var classyfedorabtn = $ConsigliereContainer/CFedoraBtn
onready var silksocksbtn = $ConsigliereContainer/SilkSocksBtn

onready var godsuitbtn = $GodfatherContainer/GSuitBtn
onready var godshoesbtn = $GodfatherContainer/GShoesBtn
onready var godcoatbtn=$GodfatherContainer/GCoatBtn

onready var ItemLbl=$InventoryPanel/VBoxContainer2/ItemLbl

onready var thetailor = $GraphicsPanel/AnimatedSprite

var itemtobuy

func _ready():
	thetailor.play("Default")
	hideconts()
	_check_rep()
	var playerRank
	playerRank=str(player_vars.rank)
	itemtobuy=0
	health.text="Health\n"+str(player_vars.health)
	ammo.text="Ammo\n"+str(player_vars.ammo)
	rep.text="Rep\n"+str(player_vars.rep)
	money.text="Money\n$"+str(player_vars.money)	
	
	match playerRank:
		"Unknown":
			var unknownitemcount = 0
			unknownContainer.show()
			
			if player_vars.UsedHandUnlock==true:
				uhandbtn.hide()
				unknownitemcount=unknownitemcount+1
			
			if player_vars.CheapSusUnlock==true:
				csusbtn.hide()
				unknownitemcount=unknownitemcount+1
			
			if unknownitemcount==2:
				textbox.text="I have nothing else for you just now.\nNow, beat it."	
			else:
				textbox.text="Here, some random crap.\nNow, beat it."
			
		"Upcoming":
			var upcomingitemcount = 0
			upcomingContainer.show()
			
			if player_vars.OldShirtUnlock==true:
				oldshirtbtn.hide()
				upcomingitemcount=upcomingitemcount+1
			
			if player_vars.StreetCapUnlock==true:
				streetcapbtn.hide()
				upcomingitemcount=upcomingitemcount+1
			
			if player_vars.CheapCaneUnlock==true:
				cheapcanebtn.hide()
				upcomingitemcount=upcomingitemcount+1
			
			if upcomingitemcount==3:
				textbox.text="I have nothing else for you just now.\nNow, beat it."	
			else:
				textbox.text="I've got some old stock beating\naround.\nYou can have it for a price."
			
		"Felon":
			var felonitemcount = 0
			felonContainer.show()
			
			if player_vars.OldSockUnlock==true:
				oldsockbtn.hide()
				felonitemcount=felonitemcount+1
			
			if player_vars.OldWaistUnlock==true:
				oldwaistcoatbtn.hide()
				felonitemcount=felonitemcount+1
			
			if player_vars.OldShoesUnlock==true:
				oldshoesbtn.hide()
				felonitemcount=felonitemcount+1
			
			if felonitemcount==3:
				textbox.text="That's it.\nYou cleared me out."	
			else:
				textbox.text="Got a bit more for a no good like yourself."
			
			
			
		"Crew Member":
			var memberitemcount = 0
			crewmemberContainer.show()
			
			if player_vars.OldTieUnlock==true:
				oldtiebtn.hide()
				memberitemcount=memberitemcount+1
			
			if player_vars.OldPantUnlock==true:
				oldpantsbtn.hide()
				memberitemcount=memberitemcount+1
			
			if player_vars.OldSuitJUnlock==true:
				oldsuitjacketbtn.hide()
				memberitemcount=memberitemcount+1
			
			if memberitemcount==3:
				textbox.text="Got nothing for you.\nTry again later."	
			else:
				textbox.text="I got some gear for you."
		
		"Associate":
			var assitemcount = 0
			associateContainer.show()
			
			if player_vars.OldCoatUnlock==true:
				oldcoatbtn.hide()
				assitemcount=assitemcount+1
			
			if player_vars.SilkPocketUnlock==true:
				silkpocketsquarebtn.hide()
				assitemcount=assitemcount+1
			
			if player_vars.ClassSusUnlock==true:
				classsusbtn.hide()
				assitemcount=assitemcount+1
			
			if assitemcount==3:
				textbox.text="Sorry, friend.\nNothing Left."	
			else:
				textbox.text="Here, check this out."
			
		"Soldier":
			var solditemcount = 0
			soldierContainer.show()
			
			if player_vars.ItalShirtUnlock==true:
				itshirtbtn.hide()
				solditemcount=solditemcount+1
			
			if player_vars.OakCaneUnlock==true:
				oakcanebtn.hide()
				solditemcount=solditemcount+1
			
			if player_vars.ItalPantUnlock==true:
				itpantbtn.hide()
				solditemcount=solditemcount+1
			
			if solditemcount==3:
				textbox.text="Got nothing i'm.\nafraid, pal."	
			else:
				textbox.text="New stock just in\n take a look."
		
		"Capo":
			var capoitemcount = 0
			capoContainer.show()
			
			if player_vars.ItalWaistUnlock==true:
				itwcoatbtn.hide()
				capoitemcount=capoitemcount+1
			
			if player_vars.ItalShoesUnlock==true:
				itshoesbtn.hide()
				capoitemcount=capoitemcount+1
			
			if player_vars.ItalSuitJUnlock==true:
				itsjacketbtn.hide()
				capoitemcount=capoitemcount+1
			
			if capoitemcount==3:
				textbox.text="Got nothing until\nthe next shipment."	
			else:
				textbox.text="New line, all italian.\n Take a look."
		
		"Underboss":
			var underitemcount = 0
			underbossContainer.show()
			
			if player_vars.SilkTieUnlock==true:
				silktiebbtn.hide()
				underitemcount=underitemcount+1
			
			if player_vars.ItalCoatUnlock==true:
				itcoatbtn.hide()
				underitemcount=underitemcount+1
			
			if player_vars.GoldSusUnlock==true:
				goldsusbtn.hide()
				underitemcount=underitemcount+1
			
			if underitemcount==3:
				textbox.text="I'll have new gear soon."	
			else:
				textbox.text="You're starting to make it\nbig."
		
		"Cosigliere":
			var consigitemcount = 0
			consigliereContainer.show()
			
			if player_vars.IvoryCaneUnlock==true:
				ivorycanebtn.hide()
				consigitemcount=consigitemcount+1
			
			if player_vars.ClassyFedoraUnlock==true:
				classyfedorabtn.hide()
				consigitemcount=consigitemcount+1
			
			if player_vars.SilkSocksUnlock==true:
				silksocksbtn.hide()
				consigitemcount=consigitemcount+1
			
			if consigitemcount==3:
				textbox.text="Come back soon, please\nsir."	
			else:
				textbox.text="Hello Sir, check out\nmy wares."
		
		"Godfather":
			var goditemcount = 0
			godfatherContainer.show()
			
			if player_vars.GodSuitUnlock==true:
				godsuitbtn.hide()
				goditemcount=goditemcount+1
			
			if player_vars.GodShoesUnlock==true:
				godshoesbtn.hide()
				goditemcount=goditemcount+1
			
			if player_vars.SilkSocksUnlock==true:
				godcoatbtn.hide()
				goditemcount=goditemcount+1
			
			if goditemcount==3:
				textbox.text="That's everything,,\ni hope it's enough."	
			else:
				textbox.text="All my best gear,\n please just take it."
			
	
	

func hideconts():
	itemimage.texture = load("")
	itemeffect.text = ""
	buyorno.hide()
	unknownContainer.hide()
	upcomingContainer.hide()
	felonContainer.hide()
	crewmemberContainer.hide()
	associateContainer.hide()
	soldierContainer.hide()
	capoContainer.hide()
	underbossContainer.hide()
	consigliereContainer.hide()
	godfatherContainer.hide()
	
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
	get_tree().change_scene("res://UI_LItalyMap.tscn")

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
	



func _on_UHandBtn_pressed():
	
	unknownContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/usedHand.png")
	itemeffect.text = "Crit + 1%"
	textbox.text = "I use that to blow my nose.\nYou can buy it if you want\nthough."
	itemtobuy=1

func _on_CSusBtn_pressed():
	unknownContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/cheapSus.png")
	itemeffect.text = "HP + 1"
	textbox.text = "These will stop your pants falling\noff."
	itemtobuy=2
	
func _on_OldShirtBtn_pressed():
	upcomingContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/OldShirt.png")
	itemeffect.text = "HP + 2"
	textbox.text = "Better than a potato sack."
	itemtobuy=3


func _on_StreetCapBtn_pressed():
	upcomingContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/StreetCap.png")
	itemeffect.text = "Crit + 1"
	textbox.text = "Will keep your head warm."
	itemtobuy=4


func _on_CheapCaneBtn_pressed():
	upcomingContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/CheapCane.png")
	itemeffect.text = "Crit + 2"
	textbox.text = "Look at mr fancy over here."
	itemtobuy=5

func _on_BuyBtn_pressed():
	var money = int(player_vars.money)
	var def = int(player_vars.defence)
	var crit = int(player_vars.equipMeleeCrit)
		
		
	if itemtobuy==1:
		if money-1 >= 0:
			money=money-1
			player_vars.money=money
			player_vars.UsedHandUnlock=true
			player_vars.totalcritboost=int(player_vars.totalcritboost)+1
			_ready()
		else:
			textbox.text = "Pfft not enough money for this?"
			
	if itemtobuy==2:
		if money-2 >= 0:
			money=money-2
			player_vars.money=money
			player_vars.CheapSusUnlock=true
			player_vars.maxHealth=int(player_vars.maxHealth)+1
			player_vars.health=int(player_vars.health)+1
			_ready()
		else:
			textbox.text = "Pfft not enough money for this?"
	
	if itemtobuy==3:
		if money-3 >= 0:
			money=money-3
			player_vars.money=money
			player_vars.OldShirtUnlock=true
			player_vars.maxHealth=int(player_vars.maxHealth)+2
			player_vars.health=int(player_vars.health)+2
			_ready()
		else:
			textbox.text = "You Broke?"
	
	if itemtobuy==4:
		if money-7 >= 0:
			money=money-7
			player_vars.money=money
			player_vars.StreetCapUnlock=true
			player_vars.totalcritboost=int(player_vars.totalcritboost)+1
			_ready()
		else:
			textbox.text = "You Broke?"
	
	if itemtobuy==5:
		if money-8 >= 0:
			money=money-8
			player_vars.money=money
			player_vars.CheapCaneUnlock=true
			player_vars.totalcritboost=int(player_vars.totalcritboost)+2
			_ready()
		else:
			textbox.text = "You Broke?"
	
	if itemtobuy==6:
		if money-8 >= 0:
			money=money-8
			player_vars.money=money
			player_vars.OldSockUnlock=true
			player_vars.maxHealth=int(player_vars.maxHealth)+2
			player_vars.health=int(player_vars.health)+2
			_ready()
		else:
			textbox.text = "You Broke?"
	
	if itemtobuy==7:
		if money-10 >= 0:
			money=money-10
			player_vars.money=money
			player_vars.OldWaistUnlock=true
			player_vars.maxHealth=int(player_vars.maxHealth)+3
			player_vars.health=int(player_vars.health)+3
			_ready()
		else:
			textbox.text = "You Broke?"
	
	if itemtobuy==8:
		if money-12 >= 0:
			money=money-12
			player_vars.money=money
			player_vars.OldShoesUnlock=true
			player_vars.maxHealth=int(player_vars.maxHealth)+3
			player_vars.health=int(player_vars.health)+3
			_ready()
		else:
			textbox.text = "You Broke?"
	
	if itemtobuy==9:
		if money-12 >= 0:
			money=money-12
			player_vars.money=money
			player_vars.OldTieUnlock=true
			player_vars.totalcritboost=int(player_vars.totalcritboost)+3
			_ready()
		else:
			textbox.text = "You Broke?"
		
	if itemtobuy==10:
		if money-13 >= 0:
			money=money-13
			player_vars.money=money
			player_vars.OldPantUnlock=true
			player_vars.maxHealth=int(player_vars.maxHealth)+3
			player_vars.health=int(player_vars.health)+3
			_ready()
		else:
			textbox.text = "You Broke?"
	
	if itemtobuy==11:
		if money-15 >= 0:
			money=money-15
			player_vars.money=money
			player_vars.OldSuitJUnlock=true
			player_vars.maxHealth=int(player_vars.maxHealth)+4
			player_vars.health=int(player_vars.health)+4
			_ready()
		else:
			textbox.text = "You Broke?"
	
	if itemtobuy==12:
		if money-15 >= 0:
			money=money-15
			player_vars.money=money
			player_vars.OldCoatUnlock=true
			player_vars.maxHealth=int(player_vars.maxHealth)+4
			player_vars.health=int(player_vars.health)+4
			_ready()
		else:
			textbox.text = "You Broke?"
	
	if itemtobuy==13:
		if money-18 >= 0:
			money=money-18
			player_vars.money=money
			player_vars.SilkPocketUnlock=true
			player_vars.totalcritboost=int(player_vars.totalcritboost)+3
			_ready()
		else:
			textbox.text = "You Broke?"
	
	if itemtobuy==14:
		if money-20 >= 0:
			money=money-20
			player_vars.money=money
			player_vars.ClassSusUnlock=true
			player_vars.totalcritboost=int(player_vars.totalcritboost)+4
			_ready()
		else:
			textbox.text = "You Broke?"
	
	if itemtobuy==15:
		if money-20 >= 0:
			money=money-20
			player_vars.money=money
			player_vars.ItalShirtUnlock=true
			player_vars.maxHealth=int(player_vars.maxHealth)+4
			player_vars.health=int(player_vars.health)+4
			_ready()
		else:
			textbox.text = "You Broke?"
	
	if itemtobuy==16:
		if money-23 >= 0:
			money=money-23
			player_vars.money=money
			player_vars.OakCaneUnlock=true
			player_vars.totalcritboost=int(player_vars.totalcritboost)+4
			_ready()
		else:
			textbox.text = "You Broke?"
	
	if itemtobuy==17:
		if money-25 >= 0:
			money=money-25
			player_vars.money=money
			player_vars.ItalPantUnlock=true
			player_vars.maxHealth=int(player_vars.maxHealth)+5
			player_vars.health=int(player_vars.health)+5
			_ready()
		else:
			textbox.text = "You Broke?"
	
	if itemtobuy==18:
		if money-25 >= 0:
			money=money-25
			player_vars.money=money
			player_vars.ItalWaistUnlock=true
			player_vars.maxHealth=int(player_vars.maxHealth)+5
			player_vars.health=int(player_vars.health)+5
			_ready()
		else:
			textbox.text = "You Broke?"
	
	if itemtobuy==19:
		if money-28 >= 0:
			money=money-28
			player_vars.money=money
			player_vars.ItalShoesUnlock=true
			player_vars.maxHealth=int(player_vars.maxHealth)+5
			player_vars.health=int(player_vars.health)+5
			_ready()
		else:
			textbox.text = "You Broke?"
	
	if itemtobuy==20:
		if money-30 >= 0:
			money=money-30
			player_vars.money=money
			player_vars.ItalSuitJUnlock=true
			player_vars.maxHealth=int(player_vars.maxHealth)+5
			player_vars.health=int(player_vars.health)+5
			_ready()
		else:
			textbox.text = "You Broke?"
	
	if itemtobuy==21:
		if money-30 >= 0:
			money=money-30
			player_vars.money=money
			player_vars.SilkTieUnlock=true
			player_vars.totalcritboost=int(player_vars.totalcritboost)+6
			_ready()
		else:
			textbox.text = "You Broke?"
	
	if itemtobuy==22:
		if money-35 >= 0:
			money=money-35
			player_vars.money=money
			player_vars.ItalCoatUnlock=true
			player_vars.maxHealth=int(player_vars.maxHealth)+6
			player_vars.health=int(player_vars.health)+6
			_ready()
		else:
			textbox.text = "You Broke?"
	
	if itemtobuy==23:
		if money-38 >= 0:
			money=money-38
			player_vars.money=money
			player_vars.GoldSusUnlock=true
			player_vars.totalcritboost=int(player_vars.totalcritboost)+7
			_ready()
		else:
			textbox.text = "You Broke?"
	
	if itemtobuy==24:
		if money-40 >= 0:
			money=money-40
			player_vars.money=money
			player_vars.IvoryCaneUnlock=true
			player_vars.totalcritboost=int(player_vars.totalcritboost)+7
			_ready()
		else:
			textbox.text = "You Broke?"
	
	if itemtobuy==25:
		if money-45 >= 0:
			money=money-45
			player_vars.money=money
			player_vars.ClassyFedoraUnlock=true
			player_vars.maxHealth=int(player_vars.maxHealth)+7
			player_vars.health=int(player_vars.health)+7
			_ready()
		else:
			textbox.text = "You Broke?"
	
	if itemtobuy==26:
		if money-50 >= 0:
			money=money-50
			player_vars.money=money
			player_vars.IvoryCaneUnlock=true
			player_vars.totalcritboost=int(player_vars.totalcritboost)+8
			_ready()
		else:
			textbox.text = "You Broke?"
	
	if itemtobuy==27:
		if money-0 >= 0:
			money=money-0
			player_vars.money=money
			player_vars.GodSuitUnlock=true
			player_vars.maxHealth=int(player_vars.maxHealth)+10
			player_vars.health=int(player_vars.health)+10
			_ready()
		else:
			textbox.text = "You Broke?"
	
	if itemtobuy==28:
		if money-0 >= 0:
			money=money-0
			player_vars.money=money
			player_vars.GodShoesUnlock=true
			player_vars.maxHealth=int(player_vars.maxHealth)+10
			player_vars.health=int(player_vars.health)+10
			_ready()
		else:
			textbox.text = "You Broke?"
	
	if itemtobuy==29:
		if money-0 >= 0:
			money=money-0
			player_vars.money=money
			player_vars.GodCoatUnlock=true
			player_vars.maxHealth=int(player_vars.maxHealth)+10
			player_vars.health=int(player_vars.health)+10
			_ready()
		else:
			textbox.text = "You Broke?"
	pass

func _on_NoBtn_pressed():
	_ready()


func _on_OSockBtn_pressed():
	felonContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/OldSock.jpg")
	itemeffect.text = "HP + 2"
	textbox.text = "That smells bad."
	itemtobuy=6


func _on_OWcoatBtn_pressed():
	felonContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/OWCoat.png")
	itemeffect.text = "HP + 3"
	textbox.text = "Not a bad fit."
	itemtobuy=7


func _on_OShoeBtn_pressed():
	felonContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/OShoe.png")
	itemeffect.text = "HP + 3"
	textbox.text = "These also smell bad."
	itemtobuy=8


func _on_OTieBtn_pressed():
	crewmemberContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/OTie.png")
	itemeffect.text = "CRIT + 3"
	textbox.text = "Who did this belong to?."
	itemtobuy=9


func _on_OPantsBtn_pressed():
	crewmemberContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/OPants.png")
	itemeffect.text = "HP + 3"
	textbox.text = "Mind the stains."
	itemtobuy=10


func _on_OSJacketBtn_pressed():
	crewmemberContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/OSuitJac.png")
	itemeffect.text = "HP + 4"
	textbox.text = "Classy, kinda."
	itemtobuy=11


func _on_OCoatBtn_pressed():
	associateContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/CheapCane.png")
	itemeffect.text = "HP + 4"
	textbox.text = "Looks pretty thick."
	itemtobuy=12


func _on_SPocketBtn_pressed():
	associateContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/CheapCane.png")
	itemeffect.text = "CRIT + 3"
	textbox.text = "Very fancy."
	itemtobuy=13


func _on_ClassSusBtn_pressed():
	associateContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/CheapCane.png")
	itemeffect.text = "CRIT + 4"
	textbox.text = "A fine purchase."
	itemtobuy=14


func _on_ItShirtBtn_pressed():
	soldierContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/CheapCane.png")
	itemeffect.text = "HP + 4"
	textbox.text = "Looks Comfy."
	itemtobuy=15

func _on_OakCaneBtn_pressed():
	soldierContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/CheapCane.png")
	itemeffect.text = "CRIT + 4"
	textbox.text = "Well, it looks sturdy."
	itemtobuy=16

func _on_ItPantBtn_pressed():
	soldierContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/CheapCane.png")
	itemeffect.text = "HP + 5"
	textbox.text = "A bit tight on the waist..."
	itemtobuy=17





func _on_ItWCoatBtn_pressed():
	capoContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/CheapCane.png")
	itemeffect.text = "HP + 5"
	textbox.text = "Reminds me of my friend\nGareth."
	itemtobuy=18


func _on_ItShoesBtn_pressed():
	capoContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/CheapCane.png")
	itemeffect.text = "HP + 5"
	textbox.text = "Just your size, great."
	itemtobuy=19


func _on_ItSJacketBtn_pressed():
	capoContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/CheapCane.png")
	itemeffect.text = "HP + 5"
	textbox.text = "Fits like a glove."
	itemtobuy=20


func _on_STieBtn_pressed():
	underbossContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/CheapCane.png")
	itemeffect.text = "CRIT + 6"
	textbox.text = "Silky."
	itemtobuy=21


func _on_ItCoatBtn_pressed():
	underbossContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/CheapCane.png")
	itemeffect.text = "HP + 6"
	textbox.text = "Warm, thick and stylish."
	itemtobuy=22


func _on_GSusBtn_pressed():
	underbossContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/CheapCane.png")
	itemeffect.text = "CRIT + 7"
	textbox.text = "Shiny."
	itemtobuy=23


func _on_ICaneBtn_pressed():
	consigliereContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/CheapCane.png")
	itemeffect.text = "CRIT + 7"
	textbox.text = "From a questionable\nsource."
	itemtobuy=24


func _on_CFedoraBtn_pressed():
	consigliereContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/CheapCane.png")
	itemeffect.text = "HP + 7"
	textbox.text = "M'  Lady."
	itemtobuy=25


func _on_SilkSocksBtn_pressed():
	consigliereContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/CheapCane.png")
	itemeffect.text = "CRIT + 8"
	textbox.text = "Silky on feet."
	itemtobuy=26


func _on_GSuitBtn_pressed():
	godfatherContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/CheapCane.png")
	itemeffect.text = "HP + 10"
	textbox.text = "Here, have this."
	itemtobuy=27


func _on_GShoesBtn_pressed():
	godfatherContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/CheapCane.png")
	itemeffect.text = "HP + 10"
	textbox.text = "Please, take it."
	itemtobuy=28


func _on_GCoatBtn_pressed():
	godfatherContainer.hide()
	buyorno.show()
	itemimage.texture = load("res://Assets/CheapCane.png")
	itemeffect.text = "HP + 10"
	textbox.text = "Just leave me be."
	itemtobuy=29

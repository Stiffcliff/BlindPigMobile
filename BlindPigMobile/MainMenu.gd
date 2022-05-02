extends Control

var day 
var month
var year
var hour
var minute 

onready var loadMenu = $Game_Loaded
onready var NoSave = $No_Save

onready var aniplayer2 =$AnimationPlayer
onready var dateLbl=$Game_Loaded/LoadedPanel/VBoxContainer/DateLabel
onready var rankLbl=$Game_Loaded/LoadedPanel/VBoxContainer/RankLabel

var save_path = "user://save.dat"
onready var player_vars = get_node("/root/PlayerVariables")

func _on_StartButton_pressed():
	aniplayer2.play("FADE4")
	yield(aniplayer2, "animation_finished")
	get_tree().change_scene("res://StartScreen.tscn")


func _on_OptionsButton_pressed():
	aniplayer2.play("FADE4")
	yield(aniplayer2, "animation_finished")
	get_tree().change_scene("res://Options.tscn")


func _on_ExitButton_pressed():
	get_tree().quit()


func _on_LoadButton_pressed():
	var file=File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			var player_data = file.get_var()
			
			day = player_data.day
			month = player_data.month
			year = player_data.year
			hour = player_data.hour
			minute  = player_data.minute
			
			player_vars.bruteContract=player_data.bruteContract
			player_vars.bruteContractCount=player_data.bruteContractCount
			
			player_vars.healContract=player_data.healContract
			player_vars.healContractCount=player_data.healContractCount
			
			player_vars.winContract=player_data.winContract
			player_vars.winContractCount=player_data.winContractCount
			
			player_vars.PistolUnlock = player_data.PistolUnlock
			player_vars.RifleUnlock = player_data.RifleUnlock
			
			player_vars.contractFailed=player_data.contractFailed
			player_vars.totalcritboost=player_data.totalcritboost
			player_vars.health=player_data.health
			player_vars.defence=player_data.defence
			player_vars.ammo=player_data.ammo
			player_vars.rep=player_data.rep
			player_vars.maxRep=player_data.maxRep
			player_vars.money=player_data.money
			player_vars.melee=player_data.melee
			player_vars.ranged=player_data.ranged
			player_vars.rank=player_data.rank
			player_vars.maxHealth=player_data.maxHealth
			player_vars.repNeeded=player_data.repNeeded
			player_vars.CosaRep=player_data.CosaRep
			player_vars.UndzerRep=player_data.UndzerRep
			player_vars.PavRep=player_data.PavRep
			player_vars.MobRep=player_data.MobRep
			
			player_vars.meleeEquip=player_data.meleeEquip
			player_vars.equipMeleeDmgMax=player_data.equipMeleeDmgMax
			player_vars.equipMeleeDmgMin=player_data.equipMeleeDmgMin
			player_vars.equipMeleeCrit=player_data.equipMeleeCrit
			
			player_vars.rangeEquip=player_data.rangeEquip
			player_vars.equipRangeDmgMax=player_data.equipRangeDmgMax
			player_vars.equipRangeDmgMin=player_data.equipRangeDmgMin
			player_vars.equipRangeCrit=player_data.equipRangeCrit
			
			player_vars.itemEquip=player_data.itemEquip
			
			player_vars.FistsUnlock=player_data.FistsUnlock
			player_vars.DustersUnlock=player_data.DustersUnlock
			player_vars.CombatKnifeUnlock=player_data.CombatKnifeUnlock
			player_vars.BowieKnifeUnlock=player_data.BowieKnifeUnlock
			
			player_vars.UsedHandUnlock=player_data.UsedHandUnlock
			player_vars.CheapSusUnlock=player_data.CheapSusUnlock
			player_vars.OldShirtUnlock=player_data.OldShirtUnlock
			player_vars.StreetCapUnlock=player_data.StreetCapUnlock
			player_vars.CheapCaneUnlock=player_data.CheapCaneUnlock
			player_vars.OldSockUnlock=player_data.OldSockUnlock
			player_vars.OldWaistUnlock=player_data.OldWaistUnlock
			player_vars.OldShoesUnlock=player_data.OldShoesUnlock
			player_vars.OldTieUnlock=player_data.OldTieUnlock
			player_vars.OldSuitJUnlock=player_data.OldSuitJUnlock
			player_vars.OldPantUnlock=player_data.OldPantUnlock
			player_vars.OldCoatUnlock=player_data.OldCoatUnlock
			player_vars.SilkPocketUnlock=player_data.SilkPocketUnlock
			player_vars.ClassSusUnlock=player_data.ClassSusUnlock
			player_vars.ItalShirtUnlock=player_data.ItalShirtUnlock
			player_vars.OakCaneUnlock=player_data.OakCaneUnlock
			player_vars.ItalPantUnlock=player_data.ItalPantUnlock
			player_vars.ItalWaistUnlock=player_data.ItalWaistUnlock
			player_vars.ItalShoesUnlock=player_data.ItalShoesUnlock
			player_vars.ItalSuitJUnlock=player_data.ItalSuitJUnlock
			player_vars.SilkTieUnlock=player_data.SilkTieUnlock
			player_vars.ItalCoatUnlock=player_data.ItalCoatUnlock
			player_vars.GoldSusUnlock=player_data.GoldSusUnlock
			player_vars.IvoryCaneUnlock=player_data.IvoryCaneUnlock
			player_vars.ClassyFedoraUnlock=player_data.ClassyFedoraUnlock
			player_vars.SilkSocksUnlock=player_data.SilkSocksUnlock
			player_vars.GodSuitUnlock=player_data.GodSuitUnlock
			player_vars.GodShoesUnlock=player_data.GodShoesUnlock
			player_vars.GodCoatUnlock=player_data.GodCoatUnlock
			
			file.close()
			
			loadMenu.show()
			if (str(minute).length()==1):
				dateLbl.text="Date: "+str(day)+"/"+str(month)+"/"+str(year)+" "+str(hour)+":0"+str(minute)
			else:
				dateLbl.text="Date: "+str(day)+"/"+str(month)+"/"+str(year)+" "+str(hour)+":"+str(minute)
				
			rankLbl.text="Rank: "+str(player_vars.rank)
			
			
	else:
		NoSave.show()

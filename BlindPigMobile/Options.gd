extends Control

var save_path = "user://save.dat"
onready var player_vars = get_node("/root/PlayerVariables")
onready var aniplayer = $AnimationPlayer

func _on_ConfirmButton_pressed():
	get_tree().change_scene("res://MainMenu.tscn")
	
func _on_QuitButton_pressed():
	get_tree().change_scene("res://MainMenu.tscn")


func _on_BackButton_pressed():
	get_tree().change_scene("res://UI_Map.tscn")


func _on_SaveButton_pressed():
	var time = OS.get_datetime()
	var day = time["day"]
	var month = time["month"]
	var year = time["year"]
	var hour = time["hour"]
	var minute = time["minute"]
	
	var data ={
		"day" : day,
		"month" : month,
		"year" : year,
		"hour" : hour,
		"minute" : minute,
		"health" : player_vars.health,
		"defence" : player_vars.defence,
		"ammo" : player_vars.ammo,
		"rep" : player_vars.rep,
		"maxRep" : player_vars.maxRep,
		"money" :  player_vars.money,
		"melee" :  player_vars.melee,
		"ranged" : player_vars.ranged,
		"rank" : player_vars.rank,
		"maxHealth" : player_vars.maxHealth,
		"repNeeded" : player_vars.repNeeded,
		"CosaRep" : player_vars.CosaRep,
		"UndzerRep" : player_vars.UndzerRep,
		"PavRep" : player_vars.PavRep,
		"MobRep" : player_vars.MobRep,
		
		"contractFailed" : player_vars.contractFailed,
		
		"totalcritboost" : player_vars.totalcritboost,
		"PistolUnlock" : player_vars.PistolUnlock,
		"RifleUnlock" : player_vars.RifleUnlock,
		
		"bruteContract" : player_vars.bruteContract,
		"bruteContractCount" : player_vars.bruteContractCount,
		
		"healContract" : player_vars.healContract,
		"healContractCount" : player_vars.healContractCount,
		
		"winContract" : player_vars.winContract,
		"winContractCount" : player_vars.winContractCount,
		
		"meleeEquip" : player_vars.meleeEquip,
		"equipMeleeDmgMax" : player_vars.equipMeleeDmgMax,
		"equipMeleeDmgMin" : player_vars.equipMeleeDmgMin,
		"equipMeleeCrit" : player_vars.equipMeleeCrit,
		
		"rangeEquip" : player_vars.rangeEquip,
		"equipRangeDmgMax" : player_vars.equipRangeDmgMax,
		"equipRangeDmgMin" : player_vars.equipRangeDmgMin,
		"equipRangeCrit" : player_vars.equipRangeCrit,
		
		"itemEquip" : player_vars.itemEquip,
		
		"FistsUnlock" : player_vars.FistsUnlock,
		"DustersUnlock" : player_vars.DustersUnlock,
		"CombatKnifeUnlock" : player_vars.CombatKnifeUnlock,
		"BowieKnifeUnlock" : player_vars.BowieKnifeUnlock,
		
		"UsedHandUnlock" : player_vars.UsedHandUnlock,
		"CheapSusUnlock" : player_vars.CheapSusUnlock,
		"OldShirtUnlock" : player_vars.OldShirtUnlock,
		"StreetCapUnlock" : player_vars.StreetCapUnlock,
		"CheapCaneUnlock" : player_vars.CheapCaneUnlock,
		"OldSockUnlock" : player_vars.OldSockUnlock,
		"OldWaistUnlock" : player_vars.OldWaistUnlock,
		"OldShoesUnlock" : player_vars.OldShoesUnlock,
		"OldTieUnlock" : player_vars.OldTieUnlock,
		"OldSuitJUnlock" : player_vars.OldSuitJUnlock,
		"OldPantUnlock" : player_vars.OldPantUnlock,
		"OldCoatUnlock" : player_vars.OldCoatUnlock,
		"SilkPocketUnlock" : player_vars.SilkPocketUnlock,
		"ClassSusUnlock" : player_vars.ClassSusUnlock,
		"ItalShirtUnlock" : player_vars.ItalShirtUnlock,
		"OakCaneUnlock" : player_vars.OakCaneUnlock,
		"ItalPantUnlock" : player_vars.ItalPantUnlock,
		"ItalWaistUnlock" : player_vars.ItalWaistUnlock,
		"ItalShoesUnlock" : player_vars.ItalShoesUnlock,
		"ItalSuitJUnlock" : player_vars.ItalSuitJUnlock,
		"SilkTieUnlock" : player_vars.SilkTieUnlock,
		"ItalCoatUnlock" : player_vars.ItalCoatUnlock,
		"GoldSusUnlock" : player_vars.GoldSusUnlock,
		"IvoryCaneUnlock" : player_vars.IvoryCaneUnlock,
		"ClassyFedoraUnlock" : player_vars.ClassyFedoraUnlock,
		"SilkSocksUnlock" : player_vars.SilkSocksUnlock,
		"GodSuitUnlock" : player_vars.GodSuitUnlock,
		"GodShoesUnlock" : player_vars.GodShoesUnlock,
		"GodCoatUnlock" : player_vars.GodCoatUnlock
	}
	
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(data)
		file.close()
		aniplayer.play("SaveDown")
		yield(aniplayer, "animation_finished")
	else:
		print ("error")

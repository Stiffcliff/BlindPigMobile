extends Control

onready var player_vars = get_node("/root/PlayerVariables")
onready var aniplayer3 =$AnimationPlayer

func _on_BeginButton_pressed():
	
	player_vars.bruteContract=false
	player_vars.bruteContractCount=0
	
	player_vars.totalcritboost=0
	
	player_vars.PistolUnlock=false
	player_vars.RifleUnlock=false
	
	player_vars.healContract=false
	player_vars.healContractCount=0
	
	player_vars.winContract=false
	player_vars.winContractCount=0
	
	player_vars.contractFailed=false
	
	player_vars.health="25"
	player_vars.defence='0'
	player_vars.ammo="0"
	player_vars.rep="0"
	player_vars.maxRep="10"
	player_vars.money="10"
	player_vars.melee="Fists"
	player_vars.ranged="None"
	player_vars.rank="Unknown"
	player_vars.maxHealth="25"
	player_vars.repNeeded="10"
	player_vars.CosaRep="0"
	player_vars.UndzerRep="0"
	player_vars.PavRep="0"
	player_vars.MobRep="0"
	
	player_vars.meleeEquip="Fists"
	player_vars.equipMeleeDmgMax="2"
	player_vars.equipMeleeDmgMin="0"
	player_vars.equipMeleeCrit="10"
	
	player_vars.rangeEquip="None"
	player_vars.equipRangeDmgMax="0"
	player_vars.equipRangeDmgMin="0"
	player_vars.equipRangeCrit="0"
	
	player_vars.GodUnlock=false
	
	player_vars.itemEquip="None"
	
	player_vars.FistsUnlock=true
	player_vars.DustersUnlock=false
	player_vars.CombatKnifeUnlock=false
	player_vars.BowieKnifeUnlock=false
	
	player_vars.UsedHandUnlock=false
	player_vars.CheapSusUnlock=false
	player_vars.OldShirtUnlock=false
	player_vars.StreetCapUnlock=false
	player_vars.CheapCaneUnlock=false
	player_vars.OldSockUnlock=false
	player_vars.OldWaistUnlock=false
	player_vars.OldShoesUnlock=false
	player_vars.OldTieUnlock=false
	player_vars.OldSuitJUnlock=false
	player_vars.OldPantUnlock=false
	player_vars.OldCoatUnlock=false
	player_vars.SilkPocketUnlock=false
	player_vars.ClassSusUnlock=false
	player_vars.ItalShirtUnlock=false
	player_vars.OakCaneUnlock=false
	player_vars.ItalPantUnlock=false
	player_vars.ItalWaistUnlock=false
	player_vars.ItalShoesUnlock=false
	player_vars.ItalSuitJUnlock=false
	player_vars.SilkTieUnlock=false
	player_vars.ItalCoatUnlock=false
	player_vars.GoldSusUnlock=false
	player_vars.IvoryCaneUnlock=false
	player_vars.ClassyFedoraUnlock=false
	player_vars.SilkSocksUnlock=false
	player_vars.GodSuitUnlock=false
	player_vars.GodShoesUnlock=false
	player_vars.GodCoatUnlock=false
	
	aniplayer3.play("FADE3")
	yield(aniplayer3, "animation_finished")
	get_tree().change_scene("res://GodCombat.tscn")

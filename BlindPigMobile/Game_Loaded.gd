extends Control

onready var loadedPanel=$LoadedPanel
onready var aniplayer=$AnimationPlayer
func _on_BackBtn_pressed():
	loadedPanel.hide()


func _on_LoadBtn_pressed():
	aniplayer.play("FADE4")
	yield(aniplayer, "animation_finished")
	get_tree().change_scene("res://UI_Map.tscn")

extends Control

onready var aniplayer1 =$AnimationPlayer

func _ready():
	aniplayer1.play("FADE1")
	yield(aniplayer1, "animation_finished")
	get_tree().change_scene("res://MainMenu.tscn")

	

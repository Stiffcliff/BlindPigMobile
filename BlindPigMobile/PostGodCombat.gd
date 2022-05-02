extends Control

onready var aniplayer3 =$AnimationPlayer
onready var player_vars = get_node("/root/PlayerVariables")
var count

onready var text1 = $InfoHolder
onready var text2 = $InfoHolder2
onready var thebutton =$BeginButton
# Called when the node enters the scene tree for the first time.
func _ready():
	count=0
	
	
func _on_BeginButton_pressed():
	count=count+1
	print(count)
	if count==1:
		thebutton.text="Awaken"
		text1.hide()
		text2.show()
		
	if count==2:
		player_vars.health=player_vars.maxHealth
		aniplayer3.play("FADE3")
		yield(aniplayer3, "animation_finished")
		get_tree().change_scene("res://UI_Map.tscn")

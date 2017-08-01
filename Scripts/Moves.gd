extends Control

var target
var player_hand

func _ready():
	pass


func _on_X_pressed():
	target.SelectionTexture.set_normal_texture(load("res://Images/Attack_Ready.png"))
	player_hand.Selection = "Attack"
	hide()
	pass # replace with function body


func _on_O_pressed():
	target.SelectionTexture.set_normal_texture(load("res://Images/Defend_Ready.png"))
	player_hand.Selection = "Defend"
	hide()
	pass # replace with function body


func _on_A_pressed():
	target.SelectionTexture.set_normal_texture(load("res://Images/Grapple_Ready.png"))
	player_hand.Selection = "Grapple"
	print(player_hand.Selection)
	hide()
	pass # replace with function body

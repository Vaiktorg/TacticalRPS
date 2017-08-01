extends Control

var wins = int()
var ties = int()
var losses = int()

var game_over = bool()

onready var label = {"Wins":get_node("Wins"),
					"Ties":get_node("Ties"),
					"Loss":get_node("Loss"),
					"ProgressBar":get_node("ProgressBar")}

onready var bg = {"Green":get_node("BG_Green"),
				"Yellow":get_node("BG_Yellow"),
				"Purple":get_node("BG_Purple")}

onready var player_ui = {"S1":{
							"PBar":get_node("Player/S1/ProgressBar"),
							"ModText":get_node("Player/S1/RichTextLabel"),
							"SelectionTexture":get_node("Player/S1")},
					"S2":{
							"PBar":get_node("Player/S2/ProgressBar"),
							"ModText":get_node("Player/S2/RichTextLabel"),
							"SelectionTexture":get_node("Player/S2")},
					"S3":{
							"PBar":get_node("Player/S3/ProgressBar"),
							"ModText":get_node("Player/S3/RichTextLabel"),
							"SelectionTexture":get_node("Player/S3")}
							}

onready var ai_ui = {"S1":{
							"PBar":get_node("AI/S1/ProgressBar"),
							"ModText":get_node("AI/S1/Text"),
							"SelectionTexture":get_node("AI/S1")},
					"S2":{
							"PBar":get_node("AI/S2/ProgressBar"),
							"ModText":get_node("AI/S2/Text"),
							"SelectionTexture":get_node("AI/S2")},
					"S3":{
							"PBar":get_node("AI/S3/ProgressBar"),
							"ModText":get_node("AI/S3/Text"),
							"SelectionTexture":get_node("AI/S3")}
							}

onready var Moves = get_parent().get_node("Moves")
onready var Player = get_parent().get_node("Player")
onready var tween = get_node("Tween")


func _ready():
	print(get_parent().game_phase)
	print(get_parent().player)
	set_process(true)
	pass

func _process(delta):

	pass


func bg_status(bg_color, boolean):
	if bg_color == "green":
		if boolean:
			bg.Green.set_texture(load("res://Images/BG_Green_Win.png"))
		else:
			bg.Green.set_texture(load("res://Images/BG_Green_Lose.png"))
			
	elif bg_color == "yellow":
		if boolean:
			bg.Yellow.set_texture(load("res://Images/BG_Yellow_Win.png"))
		else:
			bg.Yellow.set_texture(load("res://Images/BG_Yellow_Lose.png"))
	else:
		if boolean:
			bg.Purple.set_texture(load("res://Images/BG_Purple_Win.png"))
		else:
			bg.Purple.set_texture(load("res://Images/BG_Purple_Lose.png"))

func add_win():
	wins += 1
	label.Wins.set_text(str(wins))

func add_loss():
	losses += 1
	label.Loss.set_text(str(losses))

func add_tie():
	ties += 1
	label.Ties.set_text(str(ties))

func player_win(color):
	bg_status(color,true)
	add_win()

func player_loss(color):
	bg_status(color,false)
	add_loss()

# ---------- Player Signals ----------

func _on_Player_S1_pressed():
	Moves.target = player_ui.S1
	Moves.player_hand = Player.s1
	Moves.show()
	pass # replace with function body


func _on_Player_S2_pressed():
	Moves.target = player_ui.S2
	Moves.player_hand = Player.s2
	Moves.show()
	pass # replace with function body


func _on_Player_S3_pressed():
	Moves.target = player_ui.S3
	Moves.player_hand = Player.s3
	Moves.show()
	pass # replace with function body


func _on_Fight_pressed():
	get_parent().fight()
	print("Fight")
	pass # replace with function body


func get_progress_bar(side, hand):
	if side == "Player":
		if hand == "S1":
			return player_ui.S1.PBar
		if hand == "S2":
			return player_ui.S2.PBar
		else:
			return player_ui.S3.PBar

	elif side == "AI":
		if hand == "S1":
			return ai_ui.S1.PBar
		if hand == "S2":
			return ai_ui.S2.PBar
		else:
			return ai_ui.S3.PBar
			
func update_health(side,hand,health):
	tween.interpolate_property(get_progress_bar(side,hand),"range/value",get_progress_bar(side,hand).get_val(),health,1,tween.TRANS_QUAD,tween.EASE_OUT)
	tween.start()
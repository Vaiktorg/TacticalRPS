extends Control

var points = {Player=0,Ties=0,AI=0}
var AI = preload("res://Scripts/rpsAI.gd").new()
onready var label = get_node("Label")

var player_move = ""
var ai_move = ""

func _ready():
	pass

func _on_Rock_pressed():
	player_move = "Rock"
	ai_move = AI.makeMove()
	results(player_move,ai_move)
	label.set_text("Player Move: " + player_move+". " + "AI Move: " + ai_move+". " +
	"/nPlayer: " + var2str(points.Player) + ". " + "AI: " + var2str(points.AI) + ". " + "Ties: " + var2str(points.Ties) + ".")
	AI.update(player_move)
	pass # replace with function body


func _on_Paper_pressed():
	player_move = "Paper"
	ai_move = AI.makeMove()
	results(player_move,ai_move)
	label.set_text("Player Move: " + player_move+". " + "AI Move: " + ai_move+". " +
	"/nPlayer: " + var2str(points.Player) + ". " + "AI: " + var2str(points.AI) + ". " + "Ties: " + var2str(points.Ties) + ".")
	AI.update(player_move)
	pass # replace with function body


func _on_Scissor_pressed():
	player_move = "Attacks"
	ai_move = AI.makeMove()
	results(player_move,ai_move)
	label.set_text("Player Move: " + player_move+". " + "AI Move: " + ai_move+". " +
	"Player: " + var2str(points.Player) + ". " + "AI: " + var2str(points.AI) + ". " + "Ties: " + var2str(points.Ties) + ".")
	AI.update(player_move)
	pass # replace with function body


func _on_Reset_pressed():
	for pts in points:
		pts = 0
	pass # replace with function body

func results(playerMove, AIMove):
	if(playerMove == "Rock"):
		if(AIMove == "Rock"):
			print("TIE")
			return 0; #a return of 0 indicates a tie
		elif(AIMove == "Paper"):
			print("LOSE")
			return -1; #a return of -1 indicates a player 2 win (which in this case is the AI)
		else:
			print("WIN")
			return 1; #and a return of 1 indicates a player 1 win (which in this case is the player)

	elif (playerMove == "Paper"):
		if(AIMove == "Rock"):
			print("WIN")
			return 1
		elif (AIMove == "Paper"):
			print("TIE")
			return 0

		else:
			print("LOSE")
			return -1;
	else:
		if (AIMove == "Rock"):
			print("LOSE")
			return -1

		elif (AIMove == "Paper"):
			print("WIN")
			return 1
		else:
			print("TIE")
			return 0

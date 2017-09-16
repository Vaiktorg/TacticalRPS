extends Node

onready var timer = get_node("Timer")
onready var ui = get_node("UI")
onready var player = get_node("Player")
onready var ai = get_node("AI")

var round_count = int()
var game_phase = "Selection"

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		queue_free()

func _ready():
	pass

func results(playerMove, AIMove):
	if(playerMove == "Defend"):
		if(AIMove == "Defend"):
			ui.add_tie()
			return 0; #a return of 0 indicates a tie
		elif(AIMove == "Grapple"):
			ui.add_loss()
			return -1; #a return of -1 indicates a player 2 win (which in this case is the AI)
		else:
			ui.add_win()
			return 1; #and a return of 1 indicates a player 1 win (which in this case is the player)

	elif (playerMove == "Grapple"):
		if(AIMove == "Defend"):
			ui.add_win()
			return 1
		elif (AIMove == "Grapple"):
			ui.add_tie()
			return 0
		else:
			ui.add_loss()
			return -1;
	else:
		if (AIMove == "Defend"):
			ui.add_loss()
			return -1
		elif (AIMove == "Grapple"):
			ui.add_win()
			return 1
		else:
			ui.add_tie()
			return 0


func fight():
	var player_moves = [player.s1.Selection,player.s2.Selection, player.s3.Selection]
	var ai_moves = ai.move()
	var colors = ["green","purple","yellow"]

	game_phase = "Fight"
	ai.show_selection()

	for i in range(3):
		var res = results(player_moves[i],ai_moves[i])
		printt(res, player_moves[i], ai_moves[i])

		if res == 1:
			ui.bg_status(colors[i],true)
			ai.deal_damage(ai.get_hands_arr()[i],ai_moves[i])
		elif res == 0:
			ui.bg_status(colors[i],false)
		else:
			ui.bg_status(colors[i],false)
			player.deal_damage(player.get_hands_arr()[i],player_moves[i])

	ai.update_moves(player_moves)
	timer.start()
	pass

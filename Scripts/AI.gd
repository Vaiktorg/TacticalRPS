extends Node

onready var ui = get_parent().get_node("UI")

onready var rps = {"S1":get_node("RPS"),
					"S2":get_node("RPS"),
					"S3":get_node("RPS")}

var s1 = {"Selection":"",
		"Health":float(100),
		"Wins":int(),
		"Mod":null}

var s2 = {"Selection":"",
		"Health":float(100),
		"Wins":int(),
		"Mod":null}

var s3 = {"Selection":"",
		"Health":float(100),
		"Wins":int(),
		"Mod":null}

func _ready():
	ui.update_health("AI","S1",s1.Health)
	ui.update_health("AI","S2",s2.Health)
	ui.update_health("AI","S3",s3.Health)
	pass

func get_health(sel):
	if sel == "s1":
		return s1.Health
	elif sel == "s2":
		return s2.Health
	elif sel == "s3":
		return s3.Health
	elif sel == "all":
		return [s1.Health,s2.Health,s3.Health]


# Update sets the player's move so that it can guess the next player's choice.
func update_moves(playerS1, playerS2, playerS3):
	rps.S1.update(playerS1)
	rps.S2.update(playerS2)
	rps.S3.update(playerS3)

# Sets the ai's move.
func move():
	var selection = [rps.S1.move(),rps.S2.move(),rps.S3.move()]
	s1.Selection = selection[0]
	s2.Selection = selection[1]
	s3.Selection = selection[2]
	return selection

func show_selection():
	var sel_tex = [ui.ai_ui.S1.SelectionTexture, ui.ai_ui.S2.SelectionTexture, ui.ai_ui.S3.SelectionTexture]
	var sel = [s1.Selection,s2.Selection,s3.Selection]
	
	
	for i in range(3):
		var path = str("res://Images/"+sel[i]+"_Ready.png")
		sel_tex[i].set_texture(load(path))
	pass

func reset():
	s1.Selection = ""
	s2.Selection = ""
	s3.Selection = ""

func deal_damage(hand, sel):
	if hand == "S1" or hand == "S2" or hand == "S3":
		if sel == "Defend":
			hand.Health -= 5
		elif sel == "Grapple":
			hand.Health -= 10
		else:
			return
			
	ui.update_health("AI","S3",get_hands()[hand].Health)


func get_hands():
	return {"S1":s1,"S2":s2,"S3":s3}
	
func reveal():
	var hands = [s1,s2,s3]
	for hand in hands:
		if hand.Selection == "Attack":
			ui.ai_ui[hand].SelectionTexture.set_texture("res://Images/Attack_Ready.png")
		elif hand.Selection == "Defense":
			ui.ai_ui[hand].SelectionTexture.set_texture("res://Images/Defend_Ready.png")
		elif hand.Selection == "Grapple":
			ui.ai_ui[hand].SelectionTexture.set_texture("res://Images/Grapple_Ready.png")
			
		pass

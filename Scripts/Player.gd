extends Node

onready var ui = get_parent().get_node("UI")

onready var s1 = {"Selection":"",
		"Health":float(100),
		"Wins":int(),
		"Mod":null}

onready var s2 = {"Selection":"",
		"Health":float(100),
		"Wins":int(),
		"Mod":null}

onready var s3 = {"Selection":"",
		"Health":float(100),
		"Wins":int(),
		"Mod":null}

func _ready():
	ui.update_health("Player","S1",s1.Health)
	ui.update_health("Player","S2",s2.Health)
	ui.update_health("Player","S3",s3.Health)
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
		
func reset():
	s1.Selection = ""
	s2.Selection = ""
	s3.Selection = ""
	
func deal_damage(hand, sel):
	if hand == "S1" or hand == "S2" or hand == "S3":
		if sel == "Defend":
			get_hands()[hand].Health -= 5
		elif sel == "Grapple":
			get_hands()[hand].Health -= 10
		else:
			return
	ui.update_health("Player",hand,get_hands()[hand].Health)

func get_hands():
	return {"S1":s1,"S2":s2,"S3":s3}
	
func get_hands_arr():
	return ["S1", "S2", "S3"]
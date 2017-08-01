extends Node

var throws = {"Rock": 0, "Paper": 1, "Scissor": 2}
var t_prob = {"Rock":.33, "Paper":.33, "Scissor":.33}
var history = []

var p_choice = int()
var p_history = []


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
	var chain = [][]
	
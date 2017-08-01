extends Node

var deck = []
var card_limit = 10
var s
var t

func _ready():
	for c in range(card_limit):
		deck.append(str(c))
	shuffle(deck)
	printt(deck)

func shuffle(deck):
	for i in range(0,deck.size(),2):
		randomize()
		s = (randf() * i) + 1
		t = deck[s]
		deck[s] = deck[i]
		deck[i] = t
		pass
		
	
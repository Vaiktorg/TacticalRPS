extends Node

var markovChain = []
var timesPlayed = []

var lastMove = int()
var moveBeforeLast = int()


func _ready():
	randomize()
	markovChain = [[.33, .33, .33],[.33, .33, .33], [.33, .33, .33]]
	timesPlayed = [0,0,0]
	
#	load_data()

#func playerMove():
#	randomize()
#	var selection = rand_range(0,2)
#	var throws = ["Defend","Grapple","Attack"]
#	var player = throws[selection]
#	return player

func move():
	var randFloat = randf()
	if (randFloat <= markovChain[lastMove][1]):
		return "Grapple"
	elif (randFloat <= markovChain[lastMove][2] + markovChain[lastMove][1]):
		return "Attack"
	else:
		return "Defend"

func update(newMove):
	moveBeforeLast = lastMove
	if(newMove == "Defend"):
		lastMove = 0
	elif(newMove == "Grapple"):
		lastMove = 1
	else:
		lastMove = 2

# Here comes the hard part: updating the Markov Chain
	 #1. Multiply everything in the appropriate column of the Markov Chain by timesPlayed[moveBeforeLast]
	 #2. Increment the row value we want (that is, markovChain[moveBeforeLast][lastMove] by one
	 #3. Increment timesPlayed[moveBeforeLast] by one
	 #4. Divide all values in markovChain[moveBeforeLast][x] by timesPlayed[moveBeforeLast]


	for i in range(3): #1. Multiply everything in the appropriate column of the Markov Chain by timesPlayed[moveBeforeLast]
		markovChain[moveBeforeLast][i] *= timesPlayed[moveBeforeLast]

		#2. Increment the row value we want (that is, markovChain[moveBeforeLast][lastMove] by one
	markovChain[moveBeforeLast][lastMove] += 1

		#3. Increment timesPlayed[moveBeforeLast] by one
	timesPlayed[moveBeforeLast] += 1

		#4. Divide all values in markovChain[moveBeforeLast][x] by timesPlayed[moveBeforeLast]
	for j in range(3):
		markovChain[moveBeforeLast][j] /= timesPlayed[moveBeforeLast]

#	print("New Markov Chain");
#	print("Defend to Defend: " + var2str(markovChain[0][0]) + " Defend to Grapple: " + var2str(markovChain[0][1]) + " Defend to Attacks: " + var2str(markovChain[0][2]));
#	print("Grapple to Defend: " + var2str(markovChain[1][0]) + " Grapple to Grapple: " + var2str(markovChain[1][1]) + " Grapple to Attacks: " + var2str(markovChain[1][2]));
#	print("Attacks to Defend: " + var2str(markovChain[2][0]) + " Attacks to Grapple: " + var2str(markovChain[2][1]) + " Attacks to Attacks: " + var2str(markovChain[2][2]));
	
	save_data()

func save_data():
	var file = File.new()
	var data = {"TimesPlayed":timesPlayed, "MarkovChain":markovChain, "lastMove":lastMove, "moveBeforeLast":moveBeforeLast}

	file.open("res://save.txt",file.WRITE)
	if file.is_open():
		file.store_string(data.to_json())
		file.close()


func load_data():
	var file = File.new()
	var data = {}

	if file.file_exists("res://save.txt"):
		file.open("res://save.txt",file.READ)
		if file.is_open():
			data.parse_json(file.get_as_text())
			print(data)
			file.close()
		markovChain = data.MarkovChain
		timesPlayed = data.TimesPlayed
		lastMove = data.lastMove
		moveBeforeLast = data.moveBeforeLast
	
	else: print("File Doesn't Exist")

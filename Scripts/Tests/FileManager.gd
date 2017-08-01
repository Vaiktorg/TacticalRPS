extends File

var file
var to_write = {}

func _ready():
	pass

func read_file(path):
	if file_exists(path):
		open(path,READ)
		if is_open():
			file = get_as_text()
			close()
			return file
		else:
			print("File Didn't Open")
	else: print("File Doesn't Exist")
	
func read_encrypted_file(path,password):
	if file_exists(path):
		open_encrypted_with_pass(path,READ,password)
		if is_open():
			file = get_as_text()
			close()
			return file
		else:
			print("File Didn't Open")
	else: print("File Doesn't Exist")
	
func write_file(string_path,dict_data):
	if file_exists(string_path):
		open(string_path,WRITE)
		if is_open():
			to_write.parse_json(dict_data)
			store_string(to_write)
			close()
			print("Successful save.")
		else:
			close()
			print("File Didn't Open")
	else: print("File created.")
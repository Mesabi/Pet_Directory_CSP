extends Node2D


# Declare member variables here. Examples:
onready var newPet = preload("res://Scenes/Pet.tscn")
var myPets = []
var file = "res://Saves/Saves.txt"
var world

func _ready():
	pass

func test(line):
	var split = line.split("|")
	print(split.size())


# Called when the node enters the scene tree for the first time.
func CreateAllFromSave():
	world = get_tree()
	var f = File.new()
	f.open(file, File.READ)
	var index = 1
	while not f.eof_reached(): # iterate through all lines until the end of file is reached
		var line = f.get_line()
		if(line.length()>3):#weeds out end lines, broken data, etc.
			createAPet(line)
			index += 1
	f.close()
	return



func createAPet(line):
	#creates a pet from a save file line
	var split = line.split("|")
	var count = 0
	#trim empty spaces.
	for s in split:
		var str_result = s
		var unwanted_chars = [".",",",":","?"," "]
		for c in unwanted_chars:
			split[count] = str_result.replace(c,"")
		count += 1
	var pet = newPet.instance()
	self.get_parent().add_child(pet)
	#(pid, Pname, age, color, location)
	pet.set_me_up(-1, split[0], int(split[2]), split[1], self.position)



func saveFile(Pets):
	var fileNew = File.new()
	fileNew.open(file, File.WRITE)
	for pet in Pets:
		fileNew.store_line(pet.returnInfo())
	fileNew.close()
	pass
	

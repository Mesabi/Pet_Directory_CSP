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
	#needs finalization
	var split = line.split("|")
	var pet = newPet.instance()
	self.get_parent().add_child(pet)
	#(pid, Pname, age, color, location)
	pet.set_me_up(-1, split[0], int(split[1]), "red", self.position)

	

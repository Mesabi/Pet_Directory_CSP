extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Pets = []

var SelectedPets = []

onready var newPet = load("res://Scenes/Pet.tscn")
onready var inventory = get_node("Inventory")
onready var places = get_node("Waypoint_Manager")

var count = 0
var sumNames = ["bill","ted","dave"]
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	make_new_Pet()
	make_new_Pet()
	make_new_Pet()
	print(places.get_child(0).position)
	print(places.get_child(1).position)
	

	pass # Replace with function body.

func make_new_Pet():
	var pet = newPet.instance()
	add_child(pet)
	#pet.position = places.get_child(3).position
	var color = Color(rng.randf_range(0,255),rng.randf_range(0,255),rng.randf_range(0,255))
	pet.set_me_up(0, sumNames[count], count, color, places.get_child(0).global_position)
	Pets.append(pet)
	count += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	SelectedPets.clear()
	if(inventory.searching == true):
		do_search()
	if(inventory.newPetCreated == true):
		#fix later
		create_new_Pet(inventory.pet_summon)
		inventory.newPetCreated = false

func create_new_Pet(petData):
	var pet = newPet.instance()
	add_child(pet)
	print(petData.size())
	#pet.position = places.get_child(3).position
	pet.set_me_up(petData[0],petData[1],petData[2],petData[3], places.get_child(0).global_position)
	
	Pets.append(pet)
	count += 1


func do_search():
	SelectedPets.clear()
	if(inventory.ageSearch == true):
			for pet in Pets:
				#tries to cast myText as an int, will fail if not an int. 
				#actually fix this for real
				if(pet.petAge == int(inventory.myText)):
					print("found!")
					pet.go_here(places.get_child(1).global_position)
					SelectedPets.append(pet)
	else:
		for pet in Pets:
							#tries to cast myText as an int, will fail if not an int. 
			if(pet.petName == inventory.myText):
				print("found!")
				pet.go_here(places.get_child(1).global_position)
				print(pet.myPlace)
				SelectedPets.append(pet)
	if(SelectedPets.size() < 1):
		print("Pet not found!")
		return
	for pet in SelectedPets:
			print(pet.petName)


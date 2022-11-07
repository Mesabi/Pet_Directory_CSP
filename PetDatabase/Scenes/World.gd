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


func editSelected():
	SelectedPets[0].queue_free()
	SelectedPets[0] = create_new_Pet(inventory.pet_summon)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	resetArrays()
	inventory.selectionCount.text = String(SelectedPets.size())
	inventory.errorLog.text = inventory.errorText
	if(inventory.searching == true):
		deselectPets()
		SelectedPets.clear()
		do_search()
	if(inventory.newPetCreated == true):
		#fix later
		create_new_Pet(inventory.pet_summon)
		inventory.newPetCreated = false
	if(inventory.editPet == true):
		editSelected()
		inventory.editPet = false
	if(inventory.banishPet == true):
		if(SelectedPets.size()>0):
			SelectedPets[0].queue_free()
		SelectedPets.clear()
		inventory.banishPet = false
		
		
func resetArrays():
	#resets the pets array, to prevent errors
	Pets.clear()
	var world = self.get_children()
	for obj in world:
		if obj is KinematicBody2D:
			Pets.append(obj)

func create_new_Pet(petData):
	var pet = newPet.instance()
	add_child(pet)
	var placeHere = places.get_child(0).global_position
	if(inventory.editPet == true):# places it in the selection box if this is an edit.
		placeHere = places.get_child(1).global_position
	#pet.position = places.get_child(3).position
	pet.set_me_up(petData[0],petData[1],petData[2],petData[3], placeHere)
	
	Pets.append(pet)
	count += 1


func deselectPets():
	if(SelectedPets.size() > 0):
		for pet in SelectedPets:
			pet.myPlace = places.get_child(0).global_position
	else:
		pass



func do_search():
	#searches for a pet either by age or name
	#misses out on the criteria for case
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


extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Pets = []

var SelectedPets = []

onready var newPet = load("res://Scenes/Pet.tscn")
onready var petCreator = get_node("Pet_Creator")
onready var inventory = get_node("Inventory")
onready var places = get_node("Waypoint_Manager")
onready var yard = get_node("Yard")

var thing = true
var count = 0
var sumNames = ["bill","ted","dave"]
var rng = RandomNumberGenerator.new()
var childNumDefault = 0
var childNum = 0 #used to see when a new pet is added or removed.
# Called when the node enters the scene tree for the first time.
func _ready():
	childNumDefault = self.get_child_count()
	#childNum = childNumDefault
	rng.randomize()
	petCreator.CreateAllFromSave()
	pass # Replace with function body.
	

func do_thing():
	pass

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
	if(Input.is_action_pressed("Test")):
		petCreator.saveFile(Pets)
	
	#sees if new pets are added.
	if self.get_child_count() > childNumDefault:#keeps a default constant to check against
		if self.get_child_count() != childNum:#since last frame, has this changed? 
			cleanUp()
	#resetArrays()
	inventory.selectionCount.text = String(SelectedPets.size())+" / 5"
	#fix this
	inventory.errorLog.text = inventory.errorText
	if(inventory.searching == true):
		deselectPets()
		SelectedPets.clear()
		do_search()
		cleanUp()
	if(inventory.newPetCreated == true):
		#fix later
		if(Pets.size() < 5):
			create_new_Pet(inventory.pet_summon)
		inventory.newPetCreated = false
		cleanUp()
	if(inventory.editPet == true):
		editSelected()
		inventory.editPet = false
		cleanUp()
	if(inventory.banishPet == true):
		if(SelectedPets.size()>0):
			SelectedPets[0].queue_free()
		SelectedPets.clear()
		inventory.banishPet = false
		cleanUp()
	if(inventory.saveNow == true):
		petCreator.saveFile(Pets)
		inventory.saveNow = false
	
	
	
func cleanUp():
	collectPets()
	organizePets()
	childNum = self.get_child_count()

func collectPets():
	Pets.clear()
	#organizes pets in pet array.
	for child in self.get_children():
		if child is KinematicBody2D:#for the record, this only works since pets are the only member of this type. 
			Pets.append(child)
	
func organizePets():
	var amt = 1
	for pet in Pets:
		print(pet)
		if !SelectedPets.has(pet):
			print(amt)
			pet.go_here(yard.getPlace(amt))
		amt += 1

		
func resetArrays():
	#resets the pets array, to prevent errors
	#Replace later
	Pets.clear()
	var world = self.get_children()
	for obj in world:
		if obj is KinematicBody2D:
			Pets.append(obj)

func create_new_Pet(petData):
	#Not using this atm, moving to pet_creator. 
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
				#makes sure this is an int, then casts it as such
				if inventory.myText.is_valid_integer():
					if(pet.petAge == int(inventory.myText)):
						print("found!")
						pet.go_here(places.get_child(1).global_position)
						SelectedPets.append(pet)
	else:
		for pet in Pets:
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


extends Node2D

onready var background = $TextureRect
onready var searchText = $Work_Tab/SearchBox
var myText = ""
var currentDisplay
var searching = false
var ageSearch = false

var newPetCreated = false

onready var petAgeText = $Pet_Forge/Age_Text
onready var petNameText = $Pet_Forge/Name_Text

var pet_summon = [-1, "No_Text", -1, "red", self.position]
var rng = RandomNumberGenerator.new()
func _ready():
		rng.randomize()


func _process(delta):
	myText = searchText.text
	
	if(searching):
		searching = false
		ageSearch = false


func _on_Age_Search_pressed():
	searching = true
	ageSearch = true
	pass # Replace with function body.


func _on_Name_Search_pressed():
	searching = true
	pass # Replace with function body.


func _on_Create_Button_pressed():
	var temp_pet_age = -1
	if(petAgeText.text.length() < 4):#100 is the greatest pet age availalble, thus 3 digits
		#error text about word length
		if(petAgeText.text.is_valid_integer()):
			temp_pet_age = int(petAgeText.text)
		else:
			#error
			return
	else:
		#error
		return
	var color = Color(rng.randf_range(0,255),rng.randf_range(0,255),rng.randf_range(0,255))
	newPetCreated = true
	#pid, Pname, age, color, location)
	pet_summon = [-1, petNameText.text, temp_pet_age, color]

	
	
	pass # Replace with function body.

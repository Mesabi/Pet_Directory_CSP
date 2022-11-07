extends KinematicBody2D
# Declare member variables here. Examples:

var id = -1
var petName = ""
var petAge = 0
var selected = false
var myPlace = self.global_position
var target = self.global_position
var wandering = true
var overide_wander = false

var velocity = Vector2()
export (int) var speed = 40

onready var petSprite = get_node("Pet_Sprite")
onready var petLabel = get_node("Label")
var rng = RandomNumberGenerator.new()
var peltColors = [Color.red,Color.rosybrown,Color.antiquewhite,Color.coral,Color.gray,Color.brown]


func _ready():
	rng.randomize()#set up random
	target = do_wander()#set target
	
func _process(delta):
	#this block is working fine. Don't delete!		
	if position.distance_to(myPlace) > 10:
		#moves pet to designated area.
		move_here(myPlace)
	#############################################
	#I never could get the wander state figured out. maybe later
	if wandering:
		if position.distance_to(target) > 0:
			move_here(target)
		else:
			target = do_wander()
			print("reseting target")
		






func move_here(here):
	velocity = position.direction_to(here) * speed
	velocity = move_and_slide(velocity)



func set_me_up(pid, Pname, age, color, location):
	#creates a new Pet with an ID, name, age, and location.
	id = pid
	petName = Pname
	petAge = age
	petLabel.text = petName
	#could not get Pet Color to work as of now, so just doing it here, from a preselected list. 
	petSprite.modulate = peltColors[rng.randi_range(0,5)]
	self.global_position = location
	myPlace = location
	go_here(location)
	pass



func on_target():
	if(self.global_position.distance_to(myPlace)<15):
		return true
	else:
		return false




func go_here(place):
	#sets a new place for the pet to move to
	myPlace = place
	wandering = false


func enter_wander_state():
	#not working
	wandering = true
	do_wander()


func select_me():
	selected = true
	
func deselect_me():
	selected = false

func do_wander():
	#not working!!! Fix later!
	var temp = myPlace
	var offsetWander = 40
	var choose = rng.randi_range(0,4)
	# selects a random number to make an offset wander. 
	#0: nochange 1: -x 2 +x 3: -y 4: +y
	#yes I need to change this to be a switch. 
	if(choose == 0):
		pass
	else:
		temp.x = myPlace.x - offsetWander
	if(choose == 1):
		temp.x = myPlace.x + offsetWander
	if(choose == 2):
		temp.y = myPlace.y - offsetWander
	if(choose == 3):
		temp.y = myPlace.y + offsetWander
	return temp
	
	
	
	
	pass
	

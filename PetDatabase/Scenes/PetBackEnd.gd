extends KinematicBody2D
# Declare member variables here. Examples:

var id = -1
var petName = ""
var petAge = 0
var selected = false
var myPlace = self.global_position
var target = self.global_position
var wandering = false
var overide_wander = false

var velocity = Vector2()
export (int) var speed = 40

onready var petSprite = get_node("Pet_Sprite")
onready var petLabel = get_node("Label")
var rng = RandomNumberGenerator.new()
var peltColors = [Color.red,Color.rosybrown,Color.antiquewhite,Color.coral,Color.gray,Color.brown]


func _ready():
	rng.randomize()
	target = do_wander()
	print(target)
	
func _process(delta):
	# moves the pet towards where they should be

	#this block is working fine. Don't delete!		
	if position.distance_to(myPlace) > 100:
		wandering = false
		overide_wander = true
		move_here(myPlace)






func move_here(here):
	print(here)
	velocity = position.direction_to(here) * speed
	velocity = move_and_slide(velocity)



func set_me_up(pid, Pname, age, color, location):
	id = pid
	petName = Pname
	petAge = age
	petLabel.text = petName
	petSprite.modulate = peltColors[rng.randi_range(0,5)]
	self.global_position = location
	go_here(location)
	pass



func on_target():
	if(self.global_position.distance_to(myPlace)<15):
		return true
	else:
		return false




func go_here(place):
	myPlace = place
	wandering = false


func enter_wander_state():
	wandering = true
	do_wander()


func select_me():
	selected = true
	
func deselect_me():
	selected = false

func do_wander():
	return Vector2(rng.randf_range(-125,125), rng.randf_range(-125,125))
	

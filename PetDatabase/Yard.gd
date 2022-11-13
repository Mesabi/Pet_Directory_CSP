extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var p1 = get_node("Post 1")
onready var p2 = get_node("Post 2")
onready var p3 = get_node("Post 3")
onready var p4 = get_node("Post 4")
onready var p5 = get_node("Post 5")


#for setting up the locations in the script. 
func getPlace(num):
	match num:
		1:
			return p1.global_position
		2:
			return p2.global_position
		3:
			return p3.global_position
		4:
			return p4.global_position
		5:
			return p5.global_position
		_:
			return p1.global_position

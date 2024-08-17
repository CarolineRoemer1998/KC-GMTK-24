extends Node3D

var energy


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var energy = 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Close Game"):
		get_tree().quit()
	if Input.is_action_just_pressed("Reload"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("T_Grow"):
		endDay()
	
	
		
func endDay():
	get_tree().call_group("Plant","grow")
	#for child in Scene.get_children:
		#print(child.name)
		#if child is Plant:
			#print("growing")
			#child.grow()
		

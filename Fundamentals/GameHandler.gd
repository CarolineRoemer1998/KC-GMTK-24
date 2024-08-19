extends Node3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Close Game"):
		get_tree().quit()
	if Input.is_action_just_pressed("Reload"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("T_Grow"):
		end_day()
	
	
		
func end_day():
	get_tree().call_group("Plant","update_to_new_day")
	start_new_day()
	#for child in Scene.get_children:
		#print(child.name)
		#if child is Plant:
			#print("growing")
			#child.grow()
func start_new_day():
	Global.refill_energy()

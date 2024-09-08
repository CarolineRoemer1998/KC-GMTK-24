extends Node


var saved = false


func _process(_delta):
	

	if Input.is_action_just_pressed("save"):
		save_game()
	if Input.is_action_just_pressed("reload"):
		load_game()

func save_game():

	await get_tree().create_timer(0.1).timeout
	var root_node = get_tree().current_scene
	
	for child in root_node.get_children():
		child.set_owner(root_node)
		printerr(child.name)
	
	var packed_scene = PackedScene.new()
	
	#_set_owner(get_tree().current_scene, get_tree().current_scene)
	packed_scene.pack(root_node)
	ResourceSaver.save(packed_scene, "res://saved_farm.tscn")

func load_game():
	#remove_child(get_tree().current_scene)
	#get_tree().current_scene.queue_free()
	await get_tree().create_timer(0.01).timeout
	# Load the PackedScene resource
	var packed_scene = load("res://saved_farm.tscn")
	get_tree().change_scene_to_packed(packed_scene)
	await get_tree().create_timer(0.01).timeout
	Global.set_values()
	#add_child(packed_scene)
	

	
#func _set_owner(node, root):
	#if node != root:
		#node.owner = root
	#for child in node.get_children():
		#if is_instanced_from_scene(child)==false:
			#_set_owner(child, root)
		#else:
			#child.owner = root
#
#
#func is_instanced_from_scene(p_node):
	#if not p_node.filename.empty():
		#return true
	#return false

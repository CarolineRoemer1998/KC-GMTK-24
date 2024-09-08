extends Node3D

class_name Lantern

@onready var light: OmniLight3D = $Light

func turn_on():
	light.visible = true

func turn_off():
	light.visible = false

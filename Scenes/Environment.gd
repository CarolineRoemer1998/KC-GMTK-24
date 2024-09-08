extends Node3D

@onready var world_environment: WorldEnvironment = $WorldEnvironment

@onready var light_day: DirectionalLight3D = $LightDay
@onready var light_sunset: DirectionalLight3D = $LightSunset
@onready var light_night: DirectionalLight3D = $LightNight

var environment_day = preload("res://Colors/Daytimes/day.tres")
var environment_sunset = preload("res://Colors/Daytimes/sunset.tres")
var environment_night = preload("res://Colors/Daytimes/night.tres")

@onready var lanterns : Node3D = get_tree().get_first_node_in_group("Lanterns")

func _ready() -> void:
	light_day.visible = true
	light_sunset.visible = false
	light_night.visible = false
	world_environment.environment = environment_day

func change_daytime(daytime : Global.DAYTIME):
	match daytime:
		Global.DAYTIME.Day:
			light_day.visible = true
			light_sunset.visible = false
			light_night.visible = false
			world_environment.environment = environment_day
			turn_off_lanterns()
		Global.DAYTIME.Sunset:
			light_day.visible = false
			light_sunset.visible = true
			light_night.visible = false
			world_environment.environment = environment_sunset
			turn_off_lanterns()
		Global.DAYTIME.Night:
			light_day.visible = false
			light_sunset.visible = false
			light_night.visible = true
			world_environment.environment = environment_night
			turn_on_lanterns()


func turn_on_lanterns():
	for lantern in lanterns.get_children():
		if lantern is Lantern:
			lantern.turn_on()

func turn_off_lanterns():
	for lantern in lanterns.get_children():
		if lantern is Lantern:
			lantern.turn_off()

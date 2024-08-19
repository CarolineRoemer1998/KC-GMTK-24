extends Control

@onready var lawnmover = $Outer_Circle/Lawnmower_Spinner/Lawnmover

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

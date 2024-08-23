extends Control

@export var button1 : Button
@export var button2 : Button
@export var valDisplay : Label

var val1 : int
var val2 : int


func _ready() -> void:
	button1.button_down.connect(increment_and_display_val1)
	button2.button_down.connect(increment_and_display_val2)
	get_viewport().size_changed.connect(_on_resized)


func increment_and_display_val1():
	val1 += 1
	valDisplay.text = str(val1)


func increment_and_display_val2():
	val2 += 1
	valDisplay.text = str(val2)


func _on_resized() -> void:
	get_viewport().size = get_tree().root.size
	print("Updated to ", get_viewport().size)

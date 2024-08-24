class_name LiveNumbersPage
extends Control

signal disconnect_pressed

@export var button1 : Button
@export var button2 : Button
@export var valDisplay : Label
@export var disconnect_button : Button

var val1 : int
var val2 : int

func _ready() -> void:
	button1.button_down.connect(increment_and_display_val1)
	button2.button_down.connect(increment_and_display_val2)
	disconnect_button.button_down.connect(disconnect_server)

func increment_and_display_val1():
	val1 += 1
	valDisplay.text = str(val1)

func increment_and_display_val2():
	val2 += 1
	valDisplay.text = str(val2)

func disconnect_server() -> void:
	disconnect_pressed.emit()

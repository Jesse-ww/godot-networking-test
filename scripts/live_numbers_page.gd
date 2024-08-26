class_name LiveNumbersPage
extends Control

signal disconnect_pressed

@export var button1 : Button
@export var button2 : Button
@export var val_display : TextEdit
@export var disconnect_button : Button
var val1 : int
var val2 : int
var data_store : DataStore

func _ready() -> void:
	data_store = get_node("/root/MainScene/DataStore")
	button1.button_down.connect(connect_to_val_1)
	button2.button_down.connect(connect_to_val_2)
	disconnect_button.button_down.connect(disconnect_server)

func connect_to_val_1():
	data_store.update_stream.rpc(multiplayer.get_unique_id(), ClientPrefs.StreamType.DATASET_1)

func connect_to_val_2():
	data_store.update_stream.rpc(multiplayer.get_unique_id(), ClientPrefs.StreamType.DATASET_2)

func display_values(data):
	for s in data:
		val_display.text += str(s) + "\n"
		val_display.set_v_scroll(val_display.get_line_count())

@rpc("authority")
func log_value(value:String):
	val_display.text += value + "\n"
	val_display.set_v_scroll(val_display.get_line_count())

func disconnect_server() -> void:
	disconnect_pressed.emit()

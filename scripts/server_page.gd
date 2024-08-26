class_name ServerPage
extends Control

signal disconnect_pressed

@export var server_log : TextEdit
@export var command_input : LineEdit
@export var disconnect_button : Button
var data_store : DataStore

func _ready() -> void:
	data_store = get_node("/root/MainScene/DataStore")
	command_input.text_submitted.connect(enter_command)
	disconnect_button.pressed.connect(disconnect_server)

func log_to_server(message:String) -> void:
	server_log.text += message + "\n"
	var count = server_log.get_line_count()
	server_log.set_v_scroll(count)

func enter_command(command:String) -> void:
	if command == "help":
		log_to_server("Currently the only command is \"insert\"")
	if command == "insert":
		log_to_server("Sending inserted data..")
		data_store.insert_non_random_data()
	command_input.clear()

func disconnect_server() -> void:
	disconnect_pressed.emit()

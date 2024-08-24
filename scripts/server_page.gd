class_name ServerPage
extends Control

signal disconnect_pressed

@export var server_log : TextEdit
@export var command_input : LineEdit
@export var disconnect_button : Button

func _ready() -> void:
	command_input.text_submitted.connect(enter_command)
	disconnect_button.pressed.connect(disconnect_server)

func log_to_server(message:String) -> void:
	server_log.text += message + "\n"
	var count = server_log.get_line_count()
	server_log.set_v_scroll(count)

func enter_command(command:String) -> void:
	log_to_server("Executing " + command + " command")
	command_input.clear()

func disconnect_server() -> void:
	disconnect_pressed.emit()

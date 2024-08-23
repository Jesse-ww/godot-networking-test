class_name ServerPage
extends Control

@export var server_log : TextEdit
@export var command_input : LineEdit

func _ready() -> void:
	command_input.text_submitted.connect(enter_command)
	pass

func _process(delta: float) -> void:
	pass

func log_to_server(message:String) -> void:
	server_log.text += message + "\n"
	var count = server_log.get_line_count()
	server_log.set_v_scroll(count)

func enter_command(command:String) -> void:
	log_to_server("Executing " + command + " command")
	command_input.clear()

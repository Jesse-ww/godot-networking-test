class_name NetMessages
extends Node

var data_store : DataStore

func _ready() -> void:
	data_store = get_node("/root/MainScene/DataStore")

func create_nonrandom_data():
	data_store.add_data_to_set_1(12345)
	data_store.add_data_to_set_2(Time.get_datetime_string_from_unix_time(1724599640, true))

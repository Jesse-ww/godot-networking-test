class_name DataStore
extends Node2D

var delay_num : int = 0
var dataset_1 : Array[float]
var dataset_2 : Array[String]
var live_numbers : LiveNumbersPage

func _ready() -> void:
	var pages : PageManager = get_node("/root/MainScene")
	live_numbers = pages.get_page("LiveNumbersPage")

func _process(_delta: float) -> void:
	if multiplayer.is_server():
		if delay_num == 0:
			add_data_to_set_1(randf_range(-1000, 1000))
			# 1724599640 is today in unix time and 86400 = 1 day in unix time
			var randDay = 1724599640 + (randi_range(0, 365) * 86400)
			add_data_to_set_2(Time.get_datetime_string_from_unix_time(randDay, true))
			send_data_to_clients()
		if delay_num < 60:
			delay_num += 1
		else:
			delay_num = 0

func add_data_to_set_1(data:float):
	dataset_1.append(data)

func add_data_to_set_2(data:String):
	dataset_2.append(data)

func insert_non_random_data():
	add_data_to_set_1(12345)
	add_data_to_set_2("This is not a date")
	send_data_to_clients()

func send_data_to_clients():
	for c in ServerProps.connected_clients:
		if c.datastream == ClientPrefs.StreamType.DATASET_1:
			live_numbers.log_value.rpc_id(c.id, str(dataset_1[dataset_1.size()-1]))
		if c.datastream == ClientPrefs.StreamType.DATASET_2:
			live_numbers.log_value.rpc_id(c.id, dataset_2[dataset_2.size()-1])

@rpc("any_peer")
func update_stream(id:int, stream:ClientPrefs.StreamType):
	for c in ServerProps.connected_clients:
		if c.id == id:
			c.datastream = stream

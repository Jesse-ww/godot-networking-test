extends Control

@export var ip_input : LineEdit
@export var port_input : SpinBox
@export var connect_button : Button
@export var host_button : Button

var mp_system : MultiplayerSystem
var page_manager : PageManager

func _ready() -> void:
	ip_input.text = "localhost"
	port_input.value = 42
	ip_input.text_changed.connect(receive_ip)
	port_input.value_changed.connect(receive_port)
	mp_system = get_node("/root/MainScene/Multiplayer")
	host_button.pressed.connect(mp_system.host_session)
	connect_button.pressed.connect(mp_system.join_session)
	page_manager = get_node("/root/MainScene")
	mp_system.on_host.connect(open_server_page)
	mp_system.on_join.connect(open_client_page)

func _process(delta: float) -> void:
	pass

func receive_ip(ip:String):
	ServerProps.ip_address = ip

func receive_port(port:float):
	ServerProps.port = int(port)

func open_server_page() -> void:
	page_manager.open_page("ServerPage")

func open_client_page() -> void:
	page_manager.open_page("LiveNumbersPage")

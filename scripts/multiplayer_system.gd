class_name MultiplayerSystem
extends Node2D

signal on_host
signal on_join

@onready var page_manager : PageManager = get_node("/root/MainScene")
var peer : ENetMultiplayerPeer
var server_page: ServerPage


func _ready() -> void:
	server_page = page_manager.get_page("ServerPage")
	multiplayer.connected_to_server.connect(server_connected)
	multiplayer.server_disconnected.connect(server_disconnected)
	multiplayer.connection_failed.connect(connection_failed)
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)

func _process(delta: float) -> void:
	pass

func server_connected():
	server_page.log_to_server("Connected!")

func server_disconnected():
	server_page.log_to_server("Disconnected..")

func connection_failed():
	server_page.log_to_server("The connection failed!")

func peer_connected(id:int):
	server_page.log_to_server("Peer " + str(id) + " connected!")

func peer_disconnected(id:int):
	server_page.log_to_server("Peer " + str(id) + " disconnected..")

func host_session() -> void:
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(ServerProps.port)
	if error != OK:
		server_page.log_to_server("An error occurred when hosting..")
	else:
		multiplayer.set_multiplayer_peer(peer)
		on_host.emit()
		server_page.log_to_server("Waiting on players..")

func join_session() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_client(ServerProps.ip_address, ServerProps.port)
	multiplayer.set_multiplayer_peer(peer)
	on_join.emit()

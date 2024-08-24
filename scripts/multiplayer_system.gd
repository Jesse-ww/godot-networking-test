class_name MultiplayerSystem
extends Node2D

signal on_host
signal on_join

@onready var page_manager : PageManager = get_node("/root/MainScene")
var peer : ENetMultiplayerPeer
var server_page : ServerPage
var client_page : LiveNumbersPage

func _ready() -> void:
	server_page = page_manager.get_page("ServerPage")
	server_page.disconnect_pressed.connect(disconnect_session)
	client_page = page_manager.get_page("LiveNumbersPage")
	client_page.disconnect_pressed.connect(disconnect_session)
	multiplayer.connected_to_server.connect(server_connected)
	multiplayer.server_disconnected.connect(server_disconnected)
	multiplayer.connection_failed.connect(connection_failed)
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)

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

func disconnect_session() -> void:
	if peer.get_connection_status() == peer.ConnectionStatus.CONNECTION_CONNECTED:
		peer.close()
		page_manager.open_page("MainMenuPage")

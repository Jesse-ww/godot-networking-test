class_name MultiplayerSystem
extends Node2D

var peer : ENetMultiplayerPeer

func _ready() -> void:
	multiplayer.connected_to_server.connect(server_connected)
	multiplayer.server_disconnected.connect(server_disconnected)
	multiplayer.connection_failed.connect(connection_failed)
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)


func _process(delta: float) -> void:
	pass


func server_connected():
	print("Connected!")

func server_disconnected():
	print("Disconnected..")

func connection_failed():
	print("The connection failed!")

func peer_connected(id:int):
	print("Peer ", id, " connected!")

func peer_disconnected(id:int):
	print("Peer ", id, " disconnected..")

func host_session() -> void:
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(ServerProps.port)
	if error != OK:
		print("An error occurred when hosting..")
	else:
		multiplayer.set_multiplayer_peer(peer)
		print("Waiting on players..")

func join_session() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_client(ServerProps.ip_address, ServerProps.port)
	multiplayer.set_multiplayer_peer(peer)

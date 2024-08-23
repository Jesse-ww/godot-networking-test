class_name PageManager
extends Node2D

@export var pages : Array[Control]

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func open_page(name:String) -> void:
	for p in pages:
		if p.name == name:
			p.visible = true
		else:
			p.visible = false

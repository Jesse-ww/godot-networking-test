class_name PageManager
extends Node2D

@export var pages : Array[Control]

func _ready() -> void:
	pass

## Opens a single page and hides all others
func open_page(name:String) -> void:
	for p in pages:
		if p.name == name:
			p.visible = true
		else:
			p.visible = false

## Gets a page from the array of pages
func get_page(name:String) -> Control:
	for p in pages:
		if p.name == name:
			return p
	return null

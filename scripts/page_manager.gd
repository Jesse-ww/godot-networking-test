class_name PageManager
extends Node2D

@export var pages : Array[Control]

func _ready() -> void:
	pass

## Opens a single page and hides all others
func open_page(page_name:String) -> void:
	for p in pages:
		if p.name == page_name:
			p.visible = true
		else:
			p.visible = false

## Gets a page from the array of pages
func get_page(page_name:String) -> Control:
	for p in pages:
		if p.name == page_name:
			return p
	return null

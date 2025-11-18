class_name HideIfCollisionDetected
extends Node

@export var area_to_listen_to: Area3D
@export var target_node_to_hide: Node3D

func _ready() -> void:
	# Validate references
	if not area_to_listen_to:
		push_warning("HideIfCollisionDetected: 'area_to_listen_to' is not assigned.")
		return
	if not target_node_to_hide:
		push_warning("HideIfCollisionDetected: 'target_node_to_hide' is not assigned.")
		return

	# Connect signal safely
	if not area_to_listen_to.body_entered.is_connected(_on_area_body_entered):
		area_to_listen_to.body_entered.connect(_on_area_body_entered)


func _on_area_body_entered(body: Node) -> void:
	# Hide target node on collision
	set_as_hidden()


func reset_as_visible() -> void:
	if target_node_to_hide:
		target_node_to_hide.visible = true


func set_as_hidden() -> void:
	if target_node_to_hide:
		target_node_to_hide.visible = false

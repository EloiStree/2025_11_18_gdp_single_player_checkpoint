## Observe if the Node3D still exists and is still visible.
class_name DefaultObservedCheckpoints
extends Node

signal on_is_all_node_disabled()
signal on_is_one_node_enabled()
signal on_is_all_node_enabled()

@export var target_checkpoints:Array[Node3D]

@export_group("State of the checkpoints")
@export var is_one_node_enabled:bool = true
@export var is_all_node_enabled:bool = true
@export var is_all_node_disable:bool = false


func check_and_notify_state_change():
	var local_is_one_node_enabled:bool = false
	var local_is_all_node_enabled:bool = true
	var local_is_all_node_disable:bool = true

	## --- Compute states ---
	for cp in target_checkpoints:
		if cp == null or !is_instance_valid(cp):
			continue
		
		var enabled := cp.visible and cp.is_visible_in_tree()

		if enabled:
			local_is_one_node_enabled = true
			local_is_all_node_disable = false
		else:
			local_is_all_node_enabled = false

	## --- Compare with previous state & emit signals if changed ---

	if local_is_one_node_enabled != is_one_node_enabled:
		is_one_node_enabled = local_is_one_node_enabled
		if is_one_node_enabled:
			emit_signal("on_is_one_node_enabled")

	if local_is_all_node_enabled != is_all_node_enabled:
		is_all_node_enabled = local_is_all_node_enabled
		if is_all_node_enabled:
			emit_signal("on_is_all_node_enabled")

	if local_is_all_node_disable != is_all_node_disable:
		is_all_node_disable = local_is_all_node_disable
		if is_all_node_disable:
			emit_signal("on_is_all_node_disabled")



## -------------------------
##  VISIBILITY CONTROL
## -------------------------

func set_all_as_visible():
	for cp in target_checkpoints:
		if cp != null and is_instance_valid(cp):
			cp.visible = true
	check_and_notify_state_change()


func set_all_as_not_visible():
	for cp in target_checkpoints:
		if cp != null and is_instance_valid(cp):
			cp.visible = false
	check_and_notify_state_change()


func set_all_as_randomly_visible():
	randomize()
	for cp in target_checkpoints:
		if cp != null and is_instance_valid(cp):
			cp.visible = (randf() > 0.5)
	check_and_notify_state_change()



func _ready() -> void:
	is_one_node_enabled = true
	is_all_node_enabled = true
	is_all_node_disable = false
	check_and_notify_state_change()


func _process(delta: float) -> void:
	check_and_notify_state_change()


func debug_log(text:String):
	print(text)

class_name TagCheckpointNode
extends Node3D

@export var checkpoint_root_node3d:Node3D 


func get_target_root() -> Node3D:
	return checkpoint_root_node3d


func is_target_root_visible() -> bool:
	if checkpoint_root_node3d == null or !is_instance_valid(checkpoint_root_node3d):
		return false
	return checkpoint_root_node3d.visible and checkpoint_root_node3d.is_visible_in_tree()


func get_target_world_position() -> Vector3:
	if checkpoint_root_node3d == null or !is_instance_valid(checkpoint_root_node3d):
		return Vector3.ZERO
	
	# Return the world/global position of the target
	return checkpoint_root_node3d.global_transform.origin

extends Node

@export var what_to_move_root: Node3D
@export var move_interval := 0.5
@export var move_range := Vector3(5, 5, 5) # max ± range on each axis

var timer: Timer

func _ready() -> void:
	# Safety check
	if not what_to_move_root:
		push_warning("MovingRandom: 'what_to_move_root' is not assigned.")
		return

	# Create and start the timer
	timer = Timer.new()
	timer.wait_time = move_interval
	timer.autostart = true
	timer.one_shot = false
	add_child(timer)

	timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout() -> void:
	# Generate a random position within ±move_range
	var new_pos = Vector3(
		randf_range(-move_range.x, move_range.x),
		randf_range(-move_range.y, move_range.y),
		randf_range(-move_range.z, move_range.z)
	)

	# Move the assigned root node
	what_to_move_root.global_position = new_pos

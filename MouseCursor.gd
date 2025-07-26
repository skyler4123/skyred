extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	# Change the default mouse cursor
	# You can use built-in cursor shapes or load custom cursor images
	
	# Option 1: Use built-in cursor shapes
	# Input.set_default_cursor_shape(Input.CURSOR_CROSS)  # Crosshair cursor
	# Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)  # Hand cursor
	# Input.set_default_cursor_shape(Input.CURSOR_MOVE)  # Move cursor
	
	# Option 2: Load a custom cursor image (uncomment and modify path)
	# var cursor_texture = load("res://cursor.png")  # Replace with your cursor image path
	# Input.set_custom_mouse_cursor(cursor_texture, Input.CURSOR_ARROW, Vector2(0, 0))
	
	# For RTS games, crosshair is common
	Input.set_default_cursor_shape(Input.CURSOR_CROSS)

# You can also change cursor dynamically based on what you're hovering over
func _input(event):
	if event is InputEventMouseMotion:
		# Example: Change cursor when hovering over different areas
		# This is where you'd implement context-sensitive cursors
		pass

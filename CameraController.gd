extends Camera3D

@export var move_speed: float = 10.0
@export var edge_margin: int = 20
@export var zoom_speed: float = 2.0
@export var min_zoom: float = 5.0
@export var max_zoom: float = 30.0

var camera_velocity: Vector3 = Vector3.ZERO

func _ready():
	# Set initial position and rotation for RTS view
	position = Vector3(0, 10, 10)
	look_at(Vector3.ZERO, Vector3.UP)

func _input(event):
	# Handle zoom with mouse wheel
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom_camera(-zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom_camera(zoom_speed)

func _process(delta):
	handle_edge_scrolling()
	
	# Apply camera movement
	position += camera_velocity * delta

func handle_edge_scrolling():
	var viewport = get_viewport()
	var screen_size = viewport.get_visible_rect().size
	var mouse_pos = viewport.get_mouse_position()
	
	camera_velocity = Vector3.ZERO
	
	# Get camera's right and forward vectors for proper movement
	var camera_transform = global_transform
	var camera_right = camera_transform.basis.x
	var camera_forward = -camera_transform.basis.z  # Forward is negative Z
	
	# Project these vectors onto the horizontal plane (remove Y component)
	camera_right.y = 0
	camera_forward.y = 0
	camera_right = camera_right.normalized()
	camera_forward = camera_forward.normalized()
	
	# Check if mouse is at screen edges and move in screen-relative directions
	if mouse_pos.x <= edge_margin:
		# Mouse at LEFT edge -> Move camera LEFT (in screen space)
		camera_velocity = -camera_right * move_speed
	elif mouse_pos.x >= screen_size.x - edge_margin:
		# Mouse at RIGHT edge -> Move camera RIGHT (in screen space)
		camera_velocity = camera_right * move_speed
		
	if mouse_pos.y <= edge_margin:
		# Mouse at TOP edge -> Move camera UP/FORWARD (in screen space)
		camera_velocity += camera_forward * move_speed
	elif mouse_pos.y >= screen_size.y - edge_margin:
		# Mouse at BOTTOM edge -> Move camera DOWN/BACKWARD (in screen space)
		camera_velocity += -camera_forward * move_speed

func zoom_camera(zoom_amount):
	# Move camera closer/further while maintaining the angle
	var zoom_direction = (position - Vector3.ZERO).normalized()
	var new_distance = position.length() + zoom_amount
	
	# Clamp zoom distance
	new_distance = clamp(new_distance, min_zoom, max_zoom)
	
	# Apply new position
	position = zoom_direction * new_distance

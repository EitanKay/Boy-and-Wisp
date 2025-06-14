extends Camera2D

@export var player1: Node2D
@export var player2: Node2D
@export var cameraSpeed: float

var base_zoom := Vector2(1, 1)
var zoom_strength := 0.005  # Tune this to your game scale
var min_zoom := 2
var max_zoom := 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	assert (player1 or player2, "Attach players to camera")
	
	var midpoint = (player1.global_position + player2.global_position) / 2
	
	if (global_position - midpoint).length() > 10:
		global_position = global_position.lerp(midpoint, cameraSpeed)
	
	# Get distance between players
	var diff = player1.global_position - player2.global_position
	var distance = diff.length()
	
	
	# Calculate new zoom
	var zoom_factor = clamp(max_zoom + - (distance *  zoom_strength), min_zoom, max_zoom)
	zoom = Vector2(zoom_factor, zoom_factor)
	

extends RigidBody2D
class_name Wisp
@onready var physicsComponent := $PhysicsComponent

@export var drag : float = 0

@export var SPEED = 50
const HOVER_AMPLITUDE = 20.0  # How far up/down it moves
const HOVER_SPEED = 1       # How fast it moves up/down

var hover_time := 0.0
var is_idle := false

func _ready() -> void:
	pass
	

func _physics_process(delta: float) -> void:
	
	
	var directionX := Input.get_axis("wisp_left", "wisp_right")
	var directionY := Input.get_axis("wisp_up", "wisp_down")
	
	is_idle = directionX == 0 and directionY == 0

	
	apply_central_impulse(Vector2(directionX, directionY) * SPEED * delta)
	
	# fly
	apply_central_force(Vector2(0, -980))
	
	# set_linear_velocity( get_linear_velocity() )#- get_linear_velocity() * drag * delta)
	
@onready var pickable := $Pickable

func pick_up(supplier: Callable) -> void:
	pickable.pick_up(supplier)

func drop() -> void:
	pickable.drop()

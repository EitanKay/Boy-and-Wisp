extends Node

class_name PhysicsComponent

@export var mass : float = 1
@export var drag : float = 0


var _velocity : Vector2
var _acceleration : Vector2

var parent : Node2D = get_parent()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	# apply friction
	
	
	# update velocity
	#_velocity += _acceleration * delta - _velocity * drag
	
	# update location according to velocity
	#get_parent().global_position += delta * _velocity

func add_constant_force(force: Vector2) -> void:
	_acceleration += (1 / mass) * force

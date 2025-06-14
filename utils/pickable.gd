extends Node2D
class_name Pickable

@export var auto_disable_collision: bool = true
@export var collision_shape: CollisionShape2D


@onready var owner_node := get_parent() as PhysicsBody2D
var _position_supplier: Callable
var _picked_up := false

func _ready():
	
	assert(collision_shape, "Link to collision shape")
	owner_node.add_to_group("pickables")

func _physics_process(delta: float):
	if _picked_up and _position_supplier and _position_supplier.is_valid():
		owner_node.Transform.Position = _position_supplier.call()

func pick_up(position_supplier: Callable) -> void:
	_position_supplier = position_supplier
	_picked_up = true
	# owner_node.set_freeze_enabled(true)
	# collision_shape.disabled = true

func drop() -> void:
	_picked_up = false
	# owner_node.set_freeze_enabled(false)
	# collision_shape.disabled = false

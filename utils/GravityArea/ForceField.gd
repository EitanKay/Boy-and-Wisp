extends Area2D


@onready var collisionShape := $CollisionShape2D
var affectedBodies : Array[RigidBody2D] = []
@export var force_field_strength = 50
@export var exclude_body : RigidBody2D 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for body in affectedBodies:
		var direction = (body.global_position - global_position).normalized()
		var distance_squared : float = (body.global_position - global_position).length()
		print("applying force on" , body)
		body.apply_central_force(direction * force_field_strength / distance_squared)


func _on_body_entered(body: Node2D) -> void:
	if body is RigidBody2D and (body != exclude_body):
		print( "Detected : " ,body)
		affectedBodies.append(body)


func _on_body_exited(body: Node2D) -> void:
	if body in affectedBodies:
		affectedBodies.erase(body)

extends RigidBody2D

@onready var pickable := $Pickable

func pick_up(supplier: Callable) -> void:
	pickable.pick_up(supplier)

func drop() -> void:
	pickable.drop()

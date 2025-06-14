extends CharacterBody2D

class_name Boy

@export var acceleration := 10.0
@export var stopping_acceleration := 20
@export var SPEED = 100.0
@export var JUMP_VELOCITY = -400.0
@export var push_force := 80.0

@export var pickup_range := 10  # Distance threshold

@onready var interact_raycast = $InteractRaycast
@onready var animation_sprite = $AnimatedSprite2D
@onready var spring_joint = $DampedSpringJoint2D

var held_object: RigidBody2D = null

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("boy_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("boy_left", "boy_right")
	if direction:
		velocity.x = min(abs(velocity.x+direction*acceleration) ,SPEED)*direction
		animation_sprite.play("walking")
	else:
		velocity.x = move_toward(velocity.x, 0, stopping_acceleration)
		animation_sprite.play("Idle")

	move_and_slide()
	

	#player collision with object
	# This represents the player's inertia.

	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)

	# holding objects
	if direction < 0:
		animation_sprite.flip_h = true
		interact_raycast.target_position.x = pickup_range * direction
	elif direction > 0:
		animation_sprite.flip_h = false
		interact_raycast.target_position.x = pickup_range * direction
	
	if held_object:
		var new_pos = global_position + Vector2(pickup_range * direction + held_object.transform.get_scale().x , 0)
		held_object.global_position = new_pos
		#PhysicsServer2D.body_set_state(
				#held_object.get_rid(),
				#PhysicsServer2D.BODY_STATE_TRANSFORM,
				#Transform2D.IDENTITY.translated(Vector2(0,9))
			#)
		#pass
		
	if Input.is_action_just_pressed("boy_interact"):  
		var obj = interact_raycast.get_collider()
		
		if held_object:
			held_object.reparent(self.get_parent())
			
		elif obj is RigidBody2D:
			# obj.pick_up(func(): return get_global_position())
			held_object = obj
			held_object.set_freeze_mode(RigidBody2D.FREEZE_MODE_KINEMATIC)
			
			var sprite = find_child("Sprite2D")
			held_object.replace_by(sprite, )
			

			
			
			
			
				

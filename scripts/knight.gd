extends CharacterBody2D


const SPEED = 130
const JUMP_VELOCITY = -300

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$Jump.play()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction>0:
		animated_sprite.flip_h = false
	elif direction<0:
		animated_sprite.flip_h = true
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

#func check(body):
	
#	body.get_node("AnimatedSprite2D").play("death")
#	Engine.time_scale = 0.5
#	body.get_node("CollisionShape2D").queue_free()
	
@onready var player_killzone = $PlayerKillzone

func _on_shop_fruit_is_eaten():
	self.scale.x +=1
	self.scale.y +=1
	player_killzone.set_collision_mask_value(3, true)
	player_killzone.visible = true
	

func _on_player_killzone_body_entered(body):
	if body.is_in_group("enemy"):
		body.get_node("AnimatedSprite2D").play("death")
		#body.get_node("CollisionShape2D").queue_free()
		body.get_node("AudioStreamPlayer2D").play()

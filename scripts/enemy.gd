extends Node2D
const SPEED = 60
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite_2d = $AnimatedSprite2D

var direction = 1
func _physics_process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	position.x += direction*SPEED*delta
	

func _on_shop_fruit_is_eaten():
	$Killzone.set_collision_mask_value(2, false)
	$Killzone.set_collision_layer_value(3, true)
	$".".set_collision_layer_value(3, true)


func _on_animated_sprite_2d_animation_finished():
	queue_free()

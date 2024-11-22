extends Control

@onready var power_up = $PowerUp

signal fruitIsEaten
@onready var game_manager = %GameManager


func _on_button_pressed():
	if game_manager.score >= 5:
		power_up.play()
		$Panel/Sprite2D.visible = false
		$Panel/Label.text = "SOLD"
		$Panel/Button.visible = false
		emit_signal("fruitIsEaten")
func _on_shop_button_down():
	self.visible = !self.visible
	

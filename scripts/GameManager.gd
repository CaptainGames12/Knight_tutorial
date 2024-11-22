extends Node

var score = 0

@onready var score_label = %Score
@onready var shop = %Shop

func add_coin():
	score+=1
	score_label.text = "Coins: "+str(score)
	



func _on_shop_fruit_is_eaten():
	score_label.text = "Coins: "+"0"

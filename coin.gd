extends Area2D

#var coinState = 0
var coinState = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../Player".position.x = 416
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if(coinState == 3):
		coinState = 4
		$"../Player".position.y += 272.0
		visible = false
	if(coinState == 2):
		coinState = 3
		visible = false
	if(coinState == 1):
		$"../Player".position.x += 384.0
		coinState = 2
		position.x = 920
		position.y = 184

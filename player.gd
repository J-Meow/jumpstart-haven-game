extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -176.0

var climbingEnd = false
var climbingTick := 0.0

func _physics_process(delta: float) -> void:
	if position.x > 568.0 && $"../Coin".coinState < 3:
		$"../ArrowHint".visible = $"../Coin".position.x > 440.0
		position.x -= 16.0
		if($"../Coin".position.x > 424.0):
			$"../Coin".position.x -= 16.0
	if position.y > 316.0 && $"../Coin".coinState < 3:
		position.y -= 400.0
		if($"../Coin".coinState == 1):
			$"../Coin".visible = true
		if($"../Coin".coinState == 0):
			$"../Coin".coinState = 1
	if($"../Coin".coinState == 3 && position.y < 800.0 && position.x < 256.0):
		position.y += 272.0
	if($"../Coin".coinState == 3 && position.y > 800.0 && position.x > 400.0):
		$"../Coin".visible = true
		$"../Coin".position.x = 216
		$"../Coin".position.y = 952
	if(position.y > 1328.0 && position.x < 1000.0):
		position.x += 656.0
	if(position.x > 900.0 && position.x < 1050.0):
		position.x += 16.0
		position.y += 16.0
		climbingEnd = true
	if(climbingEnd):
		climbingTick += delta
		if($"../OutsideLight".energy < 6.0):
			$"../OutsideLight".energy += delta
		if($PointLight2D.energy > 0.0):
			$PointLight2D.energy -= delta
		$"../CanvasModulate".color = $"../CanvasModulate".color.lightened(delta)
		if(climbingTick > 2.0):
			get_tree().change_scene_to_file("res://end.tscn")
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if (Input.is_action_pressed("jump") or climbingEnd) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := -1.0 if climbingEnd else Input.get_axis("left", "right")
	if($"../Coin".coinState == 3 && position.y < 300.0 && direction > 0):
		direction = 0
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

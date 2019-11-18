extends KinematicBody2D

var new_ball = preload("res://Scenes/Ball.tscn")
var power_up_timer = 0
var power_up = 5
onready var default_scale = $Sprite.transform
onready var powerup_scale = $Sprite.transform.scaled(Vector2(2,1))
onready var default_c_scale = $CollisionShape2D.transform
onready var powerup_c_scale = $CollisionShape2D.transform.scaled(Vector2(2,1))

func _ready():
 set_process_input(true)

func _physics_process(delta):
 var mouse_x = get_viewport().get_mouse_position().x
 position = Vector2(mouse_x, position.y)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		print("Clicking")
		if not get_parent().has_node("Ball"):
			print("Creating a new ball")
			var ball = new_ball.instance()	
			ball.position = position - Vector2(0, 32)
			ball.name = "Ball"
			ball.linear_velocity = Vector2(200, -200)
			get_parent().add_child(ball)

func power_up():
	$Sprite.transform = powerup_scale
	$CollisionShape2D.transform = powerup_c_scale
	power_up_timer += power_up

func _on_Timer_timeout():
	if power_up_timer > 1:
		power_up_timer -= 1
	elif power_up_timer == 1:
		$Sprite.transform = default_scale
		$CollisionShape2D.transform = default_c_scale
		power_up_timer -= 1

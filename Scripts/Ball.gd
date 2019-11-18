extends RigidBody2D

export var maxspeed = 300

signal lives
signal score

var powerup = preload("res://Scenes/Power_Up.tscn")

func _ready():	
	contact_monitor = true
	set_max_contacts_reported(4)
	var WorldNode = get_node("/root/World")
	connect("score", WorldNode, "increase_score")
	connect("lives", WorldNode, "decrease_lives")

func _physics_process(delta):
	var bodies = get_colliding_bodies()
	for body in bodies:
		if body.is_in_group("Tiles"):
			emit_signal("score",body.score)
			if rand_range(0.0,1.0) > 0.9:
				var p_u = powerup.instance()	
				p_u.position = body.position + Vector2(0, 32)
				get_node("/root/World").add_child(p_u)
			body.queue_free()
		if body.get_name() == "Paddle":
			pass
  
	if position.y > get_viewport_rect().end.y:
		print("Killing")
		emit_signal("lives")
		queue_free()
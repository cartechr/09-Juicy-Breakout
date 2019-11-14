extends RigidBody2D

func _ready():	
	contact_monitor = true
	set_max_contacts_reported(4)

func _physics_process(delta):
	var bodies = get_colliding_bodies()
	for body in bodies:
		if body.get_name() == "Paddle":
			print ("powerup")
			queue_free()
  
	if position.y > get_viewport_rect().end.y:
		queue_free()
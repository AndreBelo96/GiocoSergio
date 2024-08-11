extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Se il player va in battaglia, prendere tutto ciò che è in stato battaglia ordinarlo per velocità e farli agire uno per volta
	
	if ($Player.current_state == $Player.State.BATTLE):
		print("COMBATTIMENTO")
	
	pass

extends CharacterBody2D

enum State {
	IDLE,
	MOVE,
	ATTACK,
	DEAD,
	BATTLE
}

var lifePoints
var speed
var movement
var current_state
var previous_state

func _init():
	current_state = State.IDLE;
	previous_state = State.IDLE;
	lifePoints = 20;
	speed = 15;
	movement = 1000;

func _process(delta):
	
	if velocity.length() > 0.0:
		current_state = State.MOVE
	else:
		if (current_state == State.ATTACK):
			current_state = State.ATTACK
		else:
			current_state = State.IDLE
	
	print(current_state)

func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if (current_state == State.IDLE || current_state == State.MOVE):
		velocity = direction * 600 #600 pixel al secondo
		move_and_slide()



func _input(event):
	if Input.is_action_pressed("shoot"):
		current_state = State.ATTACK
		await get_tree().create_timer(1).timeout
		$"../Enemy".lifePoints -= 5
		current_state = State.IDLE

extends CharacterBody2D

enum State {
	IDLE,
	MOVE,
	ATTACK,
	DEAD,
	BATTLE
}

const MAX_HP = 10
const MAX_ACTION = 3

var lifePoints
var speed
var movement
var current_state
var previous_state
var number_of_steps
var number_of_actions

func _init():
	current_state = State.IDLE;
	previous_state = State.IDLE;
	lifePoints = 20;
	speed = 15;
	movement = 1000;
	number_of_steps = 0;
	number_of_actions = 0;

func _process(delta):
	
	if velocity.length() == 0.0 && current_state != State.ATTACK && current_state != State.BATTLE:
		current_state = State.IDLE
	
	print(current_state)

func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if (current_state == State.IDLE || current_state == State.MOVE) && number_of_actions <= (MAX_ACTION):
		velocity = direction * 600 #600 pixel al secondo
		current_state = State.MOVE
		move_and_slide()



func _input(event):
	if Input.is_action_pressed("shoot") && number_of_actions <= (MAX_ACTION):
		current_state = State.ATTACK
		number_of_actions += 1;
		await get_tree().create_timer(1).timeout
		$"../Enemy".life_points -= 1
		current_state = State.IDLE

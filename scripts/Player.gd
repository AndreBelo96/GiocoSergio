extends CharacterBody2D

const SPEED = 100
const MAX_HP = 10
const MAX_ACTION = 3

var can_act = false;
var life_points = 20;
var speed = 15;
var movement = 1000;

var current_state
var previous_state
var number_of_steps
var number_of_actions


func _init():
	current_state = GameState.State.IDLE;
	previous_state = GameState.State.IDLE;
	number_of_steps = 0;
	number_of_actions = MAX_ACTION;

func _process(delta):
	
	if velocity.length() == 0.0 && current_state != GameState.State.ATTACK && current_state != GameState.State.BATTLE:
		previous_state = current_state
		current_state = GameState.State.IDLE
	
	
	print("PLAYER ACTION: " + str(number_of_actions))
	#print("PLAYER PREVIOUS STATE: " + str(previous_state))
	#print("PLAYER STATE: " + str(current_state))

func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if (current_state == GameState.State.IDLE || current_state == GameState.State.MOVE) && number_of_actions > 0:
		velocity = direction * 600 #600 pixel al secondo
		current_state = GameState.State.MOVE
		move_and_slide()



func _input(event):
	if Input.is_action_pressed("shoot") && number_of_actions > 0 && can_act:
		if (current_state != GameState.State.BATTLE):
			previous_state = current_state
			current_state = GameState.State.ATTACK
		await get_tree().create_timer(1).timeout
		$"../Enemy".life_points -= 1
		if (current_state != GameState.State.BATTLE):
			previous_state = current_state
			current_state = GameState.State.IDLE
		number_of_actions -= 1;

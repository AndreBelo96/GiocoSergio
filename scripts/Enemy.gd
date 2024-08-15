extends Node2D

const MAX_HP = 10
const MAX_ACTION = 3

var can_act = false;
var life_points
var speed
var movement
var range_attack
var range_battle
var number_of_steps
var number_of_actions

var current_state

# Called when the node enters the scene tree for the first time.
func _ready():
	current_state = GameState.State.IDLE;
	
	position.x = 20;
	position.y = -20;
	
	number_of_steps = 0;
	number_of_actions = MAX_ACTION;
	
	life_points = MAX_HP;
	movement = 500;
	speed = 6;
	range_attack = 150;
	range_battle = 500;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	print("ENEMY STATE: " + str(current_state))
	
	if ((check_player_in_range(range_battle) || life_points < MAX_HP) && current_state != GameState.State.DEAD):
		print("Enemy: Battle")
		current_state = GameState.State.BATTLE
		$"../Player".current_state = GameState.State.BATTLE #TODO
	else:
		current_state = GameState.State.IDLE
		print("Enemy: Idle")
	
	if (current_state == GameState.State.BATTLE && number_of_actions > 0 && can_act):
		if (check_player_in_range(range_attack)):
			print("ATTACK")
			$"../Player".life_points -= 1;
			number_of_actions -= 1;
			print("Life Player: " + str($"../Player".life_points))
			#await get_tree().create_timer(1).timeout 
		else:
			print("MOVE")
			if (number_of_steps <= movement):
				move_towards_player(movement)
			elif (number_of_steps > movement && number_of_actions > 0):
				number_of_actions -= 1;
				number_of_steps = 0;
			pass
	
	$life.text = "life: " + str(life_points)
	
	print("ENEMY ACTIONS: " + str(number_of_actions))
	
	if(life_points <= 0) :
		current_state = GameState.State.DEAD;
	
	if (current_state == GameState.State.DEAD):
		visible = false;
		# TODO delete object

## controlla se il player è in un determinato range passato  in input
func check_player_in_range(range) -> bool:
	var playerPos = $"../Player".position
	
	var xDiff = find_module(playerPos.x - position.x)
	var yDiff = find_module(playerPos.y - position.y)
	
	if (root((pow(xDiff, 2.0) + pow(yDiff,2.0)), 2.0) < range):
		return true;
	else:
		return false;

## Movimento verso il player
func move_towards_player(movement):
	var playerPos = $"../Player".position
	number_of_steps += 1;
	
	if (playerPos.x > position.x):
		position.x += 1
	else:
		position.x -= 1
	
	if (playerPos.y > position.y):
		position.y += 1
	else:
		position.y -= 1


## trova il modulo di un numero
func find_module(number) -> float:
	if (number >= 0):
		return number;
	else:
		return number * -1;

func root(n, s) -> float:
	return pow(n, (1/s))



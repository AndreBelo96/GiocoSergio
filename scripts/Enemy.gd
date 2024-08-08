extends Node2D

enum State {
	IDLE,
	MOVE,
	ATTACK,
	DEAD
}

var lifePoints
var speed
var movement

var current_state

# Called when the node enters the scene tree for the first time.
func _ready():
	current_state = State.IDLE;
	lifePoints = 10;
	movement = 500;
	speed = 10;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(lifePoints <= 0) :
		current_state = State.DEAD;
	
	if (current_state == State.DEAD):
		visible = false;

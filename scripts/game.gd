extends Node

var agents_in_combat = []
var active_agent = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Se il player va in battaglia, prendere tutto ciò che è in stato battaglia ordinarlo per velocità e farli agire uno per volta
	$Player/Camera2D/Label.text = "Life: " +str($Player.life_points)
	if ($Player.current_state == GameState.State.BATTLE && $Player.previous_state != GameState.State.BATTLE):
		init_fight()
	
	print("SIZE" + str(agents_in_combat.size()))
	
	var i = 0;
	for agent in agents_in_combat:
		if (agent.can_act):
			if (agent.number_of_actions <= 0):
				print("TURNO TERMINATO DI " + str(agent))
				agent.can_act = false
				agent.number_of_actions = agent.MAX_ACTION
				active_agent = i
				return
		i += 1
	
	
	
	if (active_agent >= 0):
		if (agents_in_combat.size() <= active_agent + 1):
			print("INIZIO TURNO DI " + str(agents_in_combat[0]))
			agents_in_combat[0].can_act = true
			active_agent = -1
		else:
			print("INIZIO TURNO DI " + str(agents_in_combat[active_agent + 1]))
			agents_in_combat[active_agent + 1].can_act = true
			active_agent = -1




func sort_ascending(a, b):
	if a.speed > b.speed:
		return true
	return false


func init_fight():
	print("COMBATTIMENTO")
	for _i in self.get_children():
		if(_i.current_state == GameState.State.BATTLE):
			agents_in_combat.push_front(_i)
			
	agents_in_combat.sort_custom(sort_ascending)
	print(agents_in_combat)
	$Player.previous_state = GameState.State.BATTLE
	
	print("SIZE" + str(agents_in_combat.size()))
	
	agents_in_combat[0].can_act = true
	
	pass




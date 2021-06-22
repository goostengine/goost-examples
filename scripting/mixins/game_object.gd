extends Mixin

var id = -1 setget set_id
var team = "Red" setget set_team


func set_id(p_id):
	id = p_id
	print("Assigned character ID: %s (game_object.gd)" % id)


func set_team(p_team):
	team = p_team
	print("Assigned character team: %s (game_object.gd)" % team)

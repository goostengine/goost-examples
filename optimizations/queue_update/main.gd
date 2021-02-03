extends Node2D

export(Resource) var res = preload("res://resource.tres")

func _ready():
	# Resource can request the update of this node upon modification.
	res.connect("changed", self, "queue_update")
#	res.connect("changed", GoostEngine, "defer_call_unique", ["update_callback"]) # One-liner.

	# Even if the resource is changed multiple times per frame,
	# this node is going to be updated only once.
	for i in 100:
		res.value += 1

func queue_update():
	GoostEngine.defer_call_unique(self, "update_callback") # Deferred.
#	update_callback() # Immediate.

func update_callback():
	# ... Heavy processing goes here ...
	$log.text += str(res.value) + "\n"

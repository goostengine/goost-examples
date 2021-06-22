extends Mixin
#
# For best results, we have to override `_notification` for callbacks such as
# `_ready`, because those are specific to GDScript and MixinScript treats those
# as actual functions, and not notifications.
#
# If a function is called from within the main script, then all the functions
# defined in mixins won't be called (skipped). Same logic applies for mixins.
#
func _notification(what):
	if what == Node.NOTIFICATION_READY:
		owner.add_to_group("characters")
		print("Added `%s` to group `characters` (agent.gd)" % owner.name)


func _ready():
	assert(false, "This callback won't be called")

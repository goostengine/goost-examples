extends Node

const ELEMENT_COUNT = 10000

class Profiler:
	var name: String
	var t1: float
	var t2: float

	func start(p_name := "Profiling result"):
		t1 = OS.get_ticks_msec()
		name = p_name

	func stop():
		t2 = OS.get_ticks_msec()
		var elapsed = t2 - t1
		print("%s: %s msec" % [name, elapsed])
		return elapsed

var profiler = Profiler.new()

func _ready():
	var methods = get_method_list()
	var tests = []
	for m in methods:
		if m.name.begins_with("test_"):
			tests.push_back(m.name)
	tests.sort()
	for test in tests:
		profiler.start(test)
		call(test)
		profiler.stop()

#===============================================================================
# Performance tests!
#===============================================================================
func test_array_push_back():
	var array = Array()
	for i in ELEMENT_COUNT:
		array.push_back("Godot")


func test_array_push_front():
	var array = Array()
	for i in ELEMENT_COUNT:
		array.push_front("Godot")


func test_list_push_back():
	var list = LinkedList.new()
	for i in ELEMENT_COUNT:
		list.push_back("Goost")


func test_list_push_front():
	var list = LinkedList.new()
	for i in ELEMENT_COUNT:
		list.push_front("Goost")

extends Node2D

func _ready():
	$MidiPlayer.load_midi("res://moonlight.mid")
	$MidiPlayer.load_soundfont("res://piano.sf2")
	$MidiPlayer.play()

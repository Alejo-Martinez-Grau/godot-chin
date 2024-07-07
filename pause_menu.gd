extends Control

signal restart

func _input(ev):
	if ev is InputEventKey and ev.pressed:

		if(ev.keycode == KEY_ENTER):
			restart.emit()

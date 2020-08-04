extends Node2D

onready var lanes = Global.lanes

func _on_Start_Button_button_down():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 
								linear2db($HSlider.value))
	if lanes == 4:
		if get_tree().change_scene("res://Scenes/Game.tscn") != OK:
			print ("Error changing scene to Game")
	else:
		if get_tree().change_scene("res://Scenes/Game2.tscn") != OK:
			print ("Error changing scene to Game")

func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),
								linear2db(value))


func _on_TextureButton_pressed():
	$TextureButton/AudioStreamPlayer.play()

func _input(event):
	if event.is_action_pressed("escape"):
		get_tree().quit()



func _on_CheckBox_toggled(button_pressed):
	if button_pressed:
		lanes = 4
	else:
		lanes = 3

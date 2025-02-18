extends Control

@onready var options_menu = $OptionsMenu
@onready var credits = $Credits
@onready var v_box_container = $VBoxContainer

func _ready() -> void:
	Input.set_custom_mouse_cursor(null)

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/character_choice_menu.tscn")

func _on_option_button_pressed():
	options_menu.visible = true 
	v_box_container.visible = false 

func _on_options_close_options():
	v_box_container.visible = true 

func _on_quit_button_pressed():
	get_tree().quit() 

func _on_credits_button_pressed():
	credits.visible = true 
	v_box_container.visible = false 

func _on_credits_close_credits():
	v_box_container.visible = true 

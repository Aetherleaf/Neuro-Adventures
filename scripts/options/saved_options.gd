extends Node

signal save_settings 

enum WindowMode {
	FULL_SCREEN,
	WINDOWED,
	BORDERLESS_WINDOW,
	BORDERLESS_FULL_SCREEN
}

var save_path = "user://saved_options.save"

#region SETTINGS
var settings := {
	"window_mode": WindowMode.WINDOWED,
	"sfx_volume": 1.0,
	"music_volume": 1.0,
	"fps_counter": true,
	"full_health_effect": false
}
#endregion 

func _ready() -> void:
	save_settings.connect(save_data)
	load_data() 
	set_default_settings()

func load_data() -> void:
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		settings = file.get_var()
	else:
		save_data()

func save_data() -> void:
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(settings)

func set_default_settings() -> void:
	set_window_mode(settings.window_mode)
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("music"), 
		linear_to_db(settings.music_volume)
	) 
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("soundfx"), 
		linear_to_db(settings.sfx_volume)
	) 

func set_window_mode(index) -> void:
	match index:
		SavedOptions.WindowMode.FULL_SCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN) 
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		SavedOptions.WindowMode.WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED) 
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		SavedOptions.WindowMode.BORDERLESS_WINDOW:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED) 
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		SavedOptions.WindowMode.BORDERLESS_FULL_SCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN) 
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true) 
		

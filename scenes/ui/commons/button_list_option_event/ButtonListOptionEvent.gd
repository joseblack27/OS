extends Button
class_name ButtonListOptionEvent

signal button_clicked(data_resource: EventData)

@onready var labels: Array[Label] = [
	$MarginContainer/VBoxContainer/HBoxContainer2/TitleLabel, 
	$MarginContainer/VBoxContainer/HBoxContainer/SubtitleLabel, 
	$MarginContainer/VBoxContainer/HBoxContainer/DateLabel
]

@onready var title_label: Label = $MarginContainer/VBoxContainer/HBoxContainer2/TitleLabel
@onready var date_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/DateLabel
@onready var subtitle_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/SubtitleLabel
@onready var texture_rect: TextureRect = $MarginContainer/VBoxContainer/HBoxContainer2/TextureRect

@export var resource: EventData

var _original_stylebox: StyleBoxFlat
var _pressed_stylebox: StyleBoxFlat
var presionado: bool = false

func setup(data: EventData):
	resource = data
	refresh()
	EventManager.event_updated.connect(_on_event_updated)

func _on_event_updated(updated_event: EventData):
	if updated_event != resource:
		return
	
	if updated_event == EventManager.event_selected:
		button_clicked.emit(resource)
	
	refresh()

func get_time_text() -> String:
	var now := Time.get_unix_time_from_system()
	
	match resource.status:
		Enums.Event.Status.UPCOMING:
			@warning_ignore("narrowing_conversion")
			return "Comienza en " + _format_time(resource.start_time - now)

		Enums.Event.Status.ACTIVE:
			@warning_ignore("narrowing_conversion")
			return "Termina en " + _format_time(resource.end_time - now)

		Enums.Event.Status.COMPLETED:
			return "Finalizado"

	return ""

func _format_time(seconds: int) -> String:
	seconds = max(seconds, 0)

	@warning_ignore("integer_division")
	var m := seconds / 60
	var s := seconds % 60

	if m > 0:
		return "%dm %ds" % [m, s]
	return "%ds" % s

func refresh():
	title_label.text = resource.title
	subtitle_label.text = resource.subtitle
	date_label.text = get_time_text()

	match resource.status:
		Enums.Event.Status.UPCOMING:
			modulate = Color.WHITE
		Enums.Event.Status.ACTIVE:
			modulate = Color(0.6, 1, 0.6)
		Enums.Event.Status.COMPLETED:
			modulate = Color(0.5, 0.5, 0.5)



func _ready():
	toggled.connect(_on_toggled)
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)
	mouse_exited.connect(_on_mouse_exited)
	
	_pressed_stylebox = StyleBoxFlat.new()
	_pressed_stylebox.bg_color = Color.WHITE
	_pressed_stylebox.set_border_width_all(1)
	_pressed_stylebox.border_color = Color(0,0,0)
	
	_original_stylebox = StyleBoxFlat.new()
	_original_stylebox.bg_color = Color.BLACK
	_original_stylebox.set_border_width_all(1)
	_original_stylebox.border_color = Color(0.267, 0.267, 0.267)
	
	label_font_white()
	background_black()

func _on_toggled(_pressed: bool) -> void:
	if _pressed:
		label_font_black()
		background_white()
		button_clicked.emit(resource)
	else:
		label_font_white()
		background_black()

func _on_button_down():
	presionado = true
	if button_pressed == true:
		label_font_black()
		background_white()
	else:
		label_font_white()
		background_black()

func _on_button_up():
	if presionado == true:
		label_font_black()
		background_white()
		presionado = false

func _on_mouse_exited():
	if presionado == true:
		if button_pressed == true:
			label_font_black()
			background_white()
		else:
			label_font_white()
			background_black()
		presionado = false


func label_font_black():
	for label in labels:
		label.add_theme_color_override("font_color", Color.BLACK)

func label_font_white():
	for label in labels:
		label.add_theme_color_override("font_color", Color.WHITE)

func background_white():
	add_theme_stylebox_override("pressed", _pressed_stylebox)
	add_theme_stylebox_override("focus", _pressed_stylebox)

func background_black():
	add_theme_stylebox_override("pressed", _original_stylebox)
	add_theme_stylebox_override("focus", _original_stylebox)

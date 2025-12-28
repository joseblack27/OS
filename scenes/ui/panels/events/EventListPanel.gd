extends Panel
class_name EventListPanel

@export var event_button_scene: PackedScene

@onready var list_container := $MarginContainer/ScrollContainer/VBoxContainer
@onready var group_button := ButtonGroup.new()

signal event_selected(event: EventData)

func build(events: Array[EventData]):
	clear()

	for event in events:
		var button: ButtonListOptionEvent = event_button_scene.instantiate()
		button.button_group = group_button
		button.button_clicked.connect(_on_event_pressed)
		list_container.add_child(button)

		button.setup(event)

func clear():
	for c in list_container.get_children():
		c.queue_free()

func _on_event_pressed(event: EventData):
	EventManager.event_selected = event
	event_selected.emit(event)

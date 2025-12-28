extends Control

@onready var list_panel: EventListPanel = $MarginContainer/HBoxContainer/EventListPanel
@onready var detail_panel: EventDetailPanel = $MarginContainer/HBoxContainer/EventDetailPanel

func _ready():
	list_panel.event_selected.connect(_on_event_selected)

	_create_test_events()
	list_panel.build(EventManager.events)

func _on_event_selected(event: EventData):
	detail_panel.show_event(event)


func _create_test_events():
	var now := Time.get_unix_time_from_system()

	var e1 := EventData.new()
	e1.id = "world_boss"
	e1.title = "Jefe de Mundo"
	e1.subtitle = "Coloso Carmesí"
	e1.description = "Una criatura ancestral ha despertado."
	e1.start_time = now + 5
	e1.end_time = now + 300

	EventManager.add_event(e1)

	var e2 := EventData.new()
	e2.id = "dungeon"
	e2.title = "Mazmorra"
	e2.subtitle = "Cripta Oscura"
	e2.description = "Una mazmorra peligrosa ha sido descubierta."
	e2.start_time = now - 60
	e2.end_time = now + 10

	EventManager.add_event(e2)

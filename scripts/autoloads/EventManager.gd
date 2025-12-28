extends Node

signal event_updated(event: EventData)
signal event_expired(event: EventData)

var events: Array[EventData] = []
var event_selected: EventData

@onready var _timer := Timer.new()

func _ready():
	_timer.wait_time = 1.0
	_timer.autostart = true
	_timer.timeout.connect(_on_tick)
	add_child(_timer)

func _on_tick():
	var now := Time.get_unix_time_from_system()

	for event in events:

		if now < event.start_time:
			event.status = Enums.Event.Status.UPCOMING
		elif now < event.end_time:
			event.status = Enums.Event.Status.ACTIVE
		else:
			event.status = Enums.Event.Status.COMPLETED
			event_expired.emit(event)
		event_updated.emit(event)

func add_event(event: EventData):
	events.append(event)
	event_updated.emit(event)

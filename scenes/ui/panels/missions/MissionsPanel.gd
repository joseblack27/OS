extends Control
class_name MissionsPanel

@onready var btn_missions_active: Button = $MarginContainer/HBox/MissionsListPanel/MarginContainer/MissionsListVBox/FilterTabs/ActiveMissionsButton
@onready var btn_missions_completed: Button = $MarginContainer/HBox/MissionsListPanel/MarginContainer/MissionsListVBox/FilterTabs/CompletedMissionsButton
@onready var btn_missions_pending: Button = $MarginContainer/HBox/MissionsListPanel/MarginContainer/MissionsListVBox/FilterTabs/PendingMissionsButton

func _ready():
	btn_missions_active.pressed.connect(set_missions_button.bind(btn_missions_active))
	btn_missions_completed.pressed.connect(set_missions_button.bind(btn_missions_completed))
	btn_missions_pending.pressed.connect(set_missions_button.bind(btn_missions_pending))
	
	set_missions_button(btn_missions_active)

func set_missions_button(button: Button):
	btn_missions_active.button_pressed = false
	btn_missions_active.disabled = false
	btn_missions_completed.button_pressed = false
	btn_missions_completed.disabled = false
	btn_missions_pending.button_pressed = false
	btn_missions_pending.disabled = false
	
	button.button_pressed = true
	button.disabled = true

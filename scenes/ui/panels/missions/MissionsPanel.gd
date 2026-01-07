extends Control
class_name MissionsPanel

@onready var btn_missions_active: Button = $MarginContainer/HBox/MissionsListPanel/MarginContainer/MissionsListVBox/FilterTabs/ActiveMissionsButton
@onready var btn_missions_completed: Button = $MarginContainer/HBox/MissionsListPanel/MarginContainer/MissionsListVBox/FilterTabs/CompletedMissionsButton
@onready var btn_missions_pending: Button = $MarginContainer/HBox/MissionsListPanel/MarginContainer/MissionsListVBox/FilterTabs/PendingMissionsButton
@onready var mission_detail_panel = $MarginContainer/HBox/MissionDetailPanel

@export var mission_data: MissionData

#region Detalle
@onready var title_label: Label = $MarginContainer/VBoxContainer/TitleLabel

@onready var type_value: Label = $MarginContainer/VBoxContainer/InfoGrid/TypeValue
@onready var level_value: Label = $MarginContainer/VBoxContainer/InfoGrid/LevelValue
@onready var region_value: Label = $MarginContainer/VBoxContainer/InfoGrid/RegionValue

@onready var description_label: Label = $MarginContainer/VBoxContainer/DescriptionLabel

@onready var objectives_vbox: VBoxContainer = $MarginContainer/VBoxContainer/ObjectivesVBox
@onready var rewards_vbox: VBoxContainer = $MarginContainer/VBoxContainer/RewardsVBox
#endregion Detalle

func _ready():
	btn_missions_active.pressed.connect(set_missions_button.bind(btn_missions_active))
	btn_missions_completed.pressed.connect(set_missions_button.bind(btn_missions_completed))
	btn_missions_pending.pressed.connect(set_missions_button.bind(btn_missions_pending))
	
	show_mission(mission_data)
	
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


func show_mission(mission: MissionData) -> void:
	if mission == null:
		clear()
		return

	title_label.text = mission.title
	#type_value.text = Enums.Mission._get_type_text(mission.type)
	level_value.text = str(mission.level_required)
	region_value.text = mission.region
	description_label.text = mission.description

	_update_objectives(mission.objectives)
	_update_rewards(mission.rewards)

func clear():
	title_label.text = "Selecciona una misión"
	type_value.text = "-"
	level_value.text = "-"
	region_value.text = "-"
	description_label.text = ""

	_clear_container(objectives_vbox)
	_clear_container(rewards_vbox)

func _update_objectives(objectives: Array[MissionObjectiveData]):
	_clear_container(objectives_vbox)

	for obj in objectives:
		var label := Label.new()
		label.text = ("✔ " if obj.is_completed else "• ") + obj.description
		label.modulate = Color(0.6, 1, 0.6) if obj.is_completed else Color.WHITE

		objectives_vbox.add_child(label)

func _update_rewards(rewards: MissionRewardData):
	_clear_container(rewards_vbox)

	if rewards.xp > 0:
		_add_reward_label("XP", rewards.xp)

	if rewards.gold > 0:
		_add_reward_label("Oro", rewards.gold)

	for item in rewards.items:
		var label := Label.new()
		label.text = item.name
		rewards_vbox.add_child(label)


func _add_reward_label(name: String, value: int):
	var label := Label.new()
	label.text = "%s: %d" % [name, value]
	rewards_vbox.add_child(label)

func _clear_container(container: Control):
	for child in container.get_children():
		child.queue_free()

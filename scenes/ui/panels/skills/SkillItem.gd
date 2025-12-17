extends Button
class_name SkillItem

signal skill_selected(skill: SkillData)

@export var skill_data: SkillData

@onready var icon_skill := $MarginContainer/HBoxContainer/Control/IconSkill
@onready var name_skill := $MarginContainer/HBoxContainer/VBoxContainer/NameSkill
@onready var level_skill := $MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/LevelSkill

func _ready():
	update_ui()

func update_ui():
	if not skill_data:
		return
	icon_skill.texture = skill_data.icon
	name_skill.text = skill_data.name
	level_skill.text = str(skill_data.level)

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		skill_selected.emit(skill_data)

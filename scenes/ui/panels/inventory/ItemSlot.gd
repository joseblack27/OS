extends Control
class_name ItemSlot

signal slot_clicked(item_data)

@export var item_data: ItemData:
	set(value):
		item_data = value
		update_item()
	get:
		return item_data

func _ready():
	gui_input.connect(_on_gui_input)

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		slot_clicked.emit(item_data)

func update_item():
	if item_data:
		$Icon.texture = item_data.icon
		$QuantityLabel.text = str(item_data.quantity) if item_data.quantity > 1 else ""
		$QuantityLabel.visible = true
	else:
		$Icon.texture = null
		$QuantityLabel.text = ""
		$QuantityLabel.visible = false

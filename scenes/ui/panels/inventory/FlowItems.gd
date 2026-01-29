extends FlowContainer
class_name FlowItems

# Tamaño mínimo deseado para cada slot
@export var min_item_size: int = 50
# Espaciado entre elementos (coincidir con Separation)
@export var spacing: int = 8

var slot_scene: PackedScene = preload("res://scenes/ui/panels/inventory/ItemSlot.tscn")
var last_filter_type: Enums.Inventory.TypeItem = Enums.Inventory.TypeItem.ALL

func _ready():
	resized.connect(_update_layout)
	_update_layout()

func _update_layout():
	if get_child_count() == 0:
		return

	var width := size.x
	if width <= 0:
		return

	# Número de columnas posibles
	var cols: int = max(1, int(width / (min_item_size + spacing)))
	# Tamaño real calculado para que encajen bien
	var cell_size := int((width - (cols - 1) * spacing) / cols)

	# Ajustar tamaño de los hijos
	for child in get_children():
		if child is Control:
			child.custom_minimum_size = Vector2(cell_size, cell_size)

func filter_items(filter_type: Enums.Inventory.TypeItem):
	last_filter_type = filter_type
	for item: ItemSlot in get_children():
		if filter_type == Enums.Inventory.TypeItem.ALL:
			item.visible = true
		else:
			item.visible = item.item_data.type == filter_type

func _can_drop_data(_at_position, data):
	return data is EquipoSlot

func _drop_data(_at_position, data):
	var item_slot = data
	
	var slot: ItemSlot = slot_scene.instantiate()
	slot.item_data = item_slot.item_data
	slot.slot_clicked.connect(owner._on_slot_clicked)
	slot.slot_dragging.connect(owner._on_slot_dragging)
	slot.custom_minimum_size = Vector2(53,53)
	add_child(slot)
	item_slot.item_data = null
	
	filter_items(last_filter_type)

extends FlowContainer
class_name FlowItems

# Tamaño mínimo deseado para cada slot
@export var min_item_size: int = 50
# Espaciado entre elementos (coincidir con Separation)
@export var spacing: int = 8


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

func filter_items(filter_type: Enums.type_item_inventory):
	for item: ItemSlot in get_children():
		if filter_type == Enums.type_item_inventory.ALL:
			item.visible = true
		else:
			item.visible = item.item_data.type == filter_type

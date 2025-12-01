extends Control
class_name InventoryPanel

@export var slot_scene: PackedScene          # ItemSlot.tscn
@export var items: Array[ItemData] = []      # Lista de items del jugador
@export var slot_size := Vector2(53, 53)     # tamaño del slot
@export var min_spacing := 4                 # mínimo espacio permitido

@onready var grid: GridContainer = $Margin/HBox/ItemsPanel/MarginContainer/ItemsVBox/GridContainer
@onready var flow: FlowItems = $Margin/HBox/ItemsPanel/MarginContainer/ItemsVBox/FlowItems

# Detalle
@onready var item_name := $Margin/HBox/DetailPanel/MarginContainer/DetailVBox/ItemName
@onready var item_icon := $Margin/HBox/DetailPanel/MarginContainer/DetailVBox/ItemIcon
@onready var type_value := $Margin/HBox/DetailPanel/MarginContainer/DetailVBox/InfoGrid/TypeValue
@onready var qty_value := $Margin/HBox/DetailPanel/MarginContainer/DetailVBox/InfoGrid/QtyValue
@onready var description_text := $Margin/HBox/DetailPanel/MarginContainer/DetailVBox/DescriptionText
@onready var close_button := $Margin/HBox/DetailPanel/MarginContainer/CloseButton
@onready var detail_panel_margin := $Margin/HBox/DetailPanel/MarginContainer

@onready var use_button := $Margin/HBox/DetailPanel/MarginContainer/DetailVBox/ButtonBar/UseButton
@onready var equip_button := $Margin/HBox/DetailPanel/MarginContainer/DetailVBox/ButtonBar/EquipButton
@onready var drop_button := $Margin/HBox/DetailPanel/MarginContainer/DetailVBox/ButtonBar/DropButton

func _ready():
	#_populate_grid()
	#flow.resized.connect(_on_flow)
	flow.resized.connect(_update_spacing)
	_populate_flow()
	_clear_details()
	#resized.connect(_update_spacing)
	close_button.pressed.connect(_on_close_button)
	_update_spacing()
	#_on_flow()

func _populate_flow():
	for child in grid.get_children():
		child.queue_free()

	for data in items:
		var slot: ItemSlot = slot_scene.instantiate()
		slot.item_data = data
		slot.slot_clicked.connect(_on_slot_clicked)
		flow.add_child(slot)

func _on_close_button():
	detail_panel_margin.hide()

func _update_spacing_2():
	var container_width: float = flow.size.x
	print(container_width)
	
	var slot_w: float = slot_size.x
	print(slot_w)
	
	var max_per_row: int = max(1, floor(container_width / slot_w))
	print(max_per_row)
	
	var width_rest: int = int(container_width) % int(slot_w)
	print(container_width, " % ", slot_w, " = ", width_rest)
	
	#var width_x_slot = max_per_row * slot_w # 384
	if (max_per_row - 1) > 0:
		@warning_ignore("integer_division")
		var spacing: int = floori(width_rest / (max_per_row - 1)) # 8
		print("espaciado: ", spacing)
		
		if spacing < min_spacing:
			spacing = floori(width_rest + slot_w / (max_per_row - 1))
		flow.add_theme_constant_override("h_separation", spacing)
		flow.add_theme_constant_override("v_separation", spacing)

func _update_spacing():
	# 1. Tamaño real disponible del FlowContainer
	var container_width: float = flow.size.x


	# 2. Obtener el tamaño REAL del slot (min size)
	var sample_slot := slot_scene.instantiate()
	var slot_w: float = sample_slot.get_combined_minimum_size().x
	sample_slot.queue_free()

	# 3. Cálculo de cuántos caben
	var max_per_row: int = max(1, floor(container_width / (slot_w + min_spacing)))

	# 4. Calcular espacio restante
	var used_width: float = max_per_row * slot_w
	var free_space: float = container_width - used_width

	# 5. Calcular spacing ideal
	var spacing: int = floori(free_space / (max_per_row + 1))

	# 6. Limitar spacing
	spacing = max(spacing, min_spacing)

	# 7. Aplicar spacing
	flow.add_theme_constant_override("h_separation", spacing)
	flow.add_theme_constant_override("v_separation", spacing)

func _populate_grid():
	_clear_grid(grid)

	for data in items:
		var slot := slot_scene.instantiate()
		slot.item_data = data
		slot.slot_clicked.connect(_on_slot_clicked)
		grid.add_child(slot)

func _clear_grid(_grid):
	for child in _grid.get_children():
		child.queue_free()

func _on_slot_clicked(item_data: ItemData):
	_update_details(item_data)
	detail_panel_margin.show()

func _clear_details():
	item_name.text = "No item"
	item_icon.texture = null
	type_value.text = "-"
	qty_value.text = "-"
	description_text.text = ""
	
	use_button.disabled = true
	equip_button.disabled = true
	drop_button.disabled = true

func _update_details(item: ItemData):
	item_name.text = item.name
	item_icon.texture = item.icon
	type_value.text = item.type_descripcion
	qty_value.text = str(item.quantity)
	description_text.text = item.description

	# Habilitar según tipo
	use_button.disabled = not item.can_use
	equip_button.disabled = not item.can_equip
	drop_button.disabled = false

func _on_flow():
	_update_spacing_2()

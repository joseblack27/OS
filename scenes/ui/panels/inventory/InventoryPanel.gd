extends Control
class_name InventoryPanel

@export var slot_scene: PackedScene          # ItemSlot.tscn
@export var items: Array[ItemData] = []      # Lista de items del jugador
@export var slot_size := Vector2(53, 53)     # tamaño del slot
@export var min_spacing := 4                 # mínimo espacio permitido

@onready var grid: GridContainer = $Margin/HBox/ItemsPanel/MarginContainer/ItemsVBox/GridContainer
@onready var flow: FlowItems = $Margin/HBox/ItemsPanel/MarginContainer/ItemsVBox/MarginContainer/ScrollContainer/FlowItems

# Panel de detalle
@onready var item_name := $Margin/HBox/Control/DetailPanel/MarginContainer/DetailVBox/ItemName
@onready var item_icon := $Margin/HBox/Control/DetailPanel/MarginContainer/DetailVBox/ItemIcon
@onready var type_value := $Margin/HBox/Control/DetailPanel/MarginContainer/DetailVBox/MarginContainer/InfoGrid/TypeValue
@onready var qty_value := $Margin/HBox/Control/DetailPanel/MarginContainer/DetailVBox/MarginContainer/InfoGrid/QtyValue
@onready var description_text := $Margin/HBox/Control/DetailPanel/MarginContainer/DetailVBox/MarginContainer2/VBoxContainer/DescriptionText
@onready var close_button := $Margin/HBox/Control/DetailPanel/CloseButton
@onready var detail_panel_margin := $Margin/HBox/Control/DetailPanel

@onready var use_button := $Margin/HBox/Control/DetailPanel/MarginContainer/DetailVBox/ButtonBar/UseButton
@onready var equip_button := $Margin/HBox/Control/DetailPanel/MarginContainer/DetailVBox/ButtonBar/EquipButton
@onready var drop_button := $Margin/HBox/Control/DetailPanel/MarginContainer/DetailVBox/ButtonBar/DropButton
@onready var action_button := $Margin/HBox/Control/DetailPanel/MarginContainer/DetailVBox/ActionButton

@onready var main_action_panel: PanelContainer = $Margin/HBox/Control/DetailPanel/MainActionPanel
@onready var use_action_button := $Margin/HBox/Control/DetailPanel/MainActionPanel/MarginContainer/VBoxContainer/UseButton
@onready var equip_action_button := $Margin/HBox/Control/DetailPanel/MainActionPanel/MarginContainer/VBoxContainer/EquipButton
@onready var drop_action_button := $Margin/HBox/Control/DetailPanel/MainActionPanel/MarginContainer/VBoxContainer/DropButton

@onready var all_filter_button: Button = $Margin/HBox/ItemsPanel/MarginContainer/ItemsVBox/FilterTabs/AllButton
@onready var equipments_filter_button: Button = $Margin/HBox/ItemsPanel/MarginContainer/ItemsVBox/FilterTabs/EquipmentsButton
@onready var consumables_filter_button: Button = $Margin/HBox/ItemsPanel/MarginContainer/ItemsVBox/FilterTabs/ConsumablesButton
@onready var resources_filter_button: Button = $Margin/HBox/ItemsPanel/MarginContainer/ItemsVBox/FilterTabs/ResourcesButton

# Panel de equipamiento
@onready var equipment_panel: Panel = $Margin/HBox/Control/EquipmentPanel
@onready var equip_slot_weapon: EquipoSlot = $Margin/HBox/Control/EquipmentPanel/MarginContainer/EquipmentVBox/HBoxContainer1/EquipSlotWeapon
@onready var equip_slot_shield: EquipoSlot = $Margin/HBox/Control/EquipmentPanel/MarginContainer/EquipmentVBox/HBoxContainer1/EquipSlotShield
@onready var equip_slot_helmet: EquipoSlot = $Margin/HBox/Control/EquipmentPanel/MarginContainer/EquipmentVBox/HBoxContainer2/EquipSlotHelmet
@onready var equip_slot_neck: EquipoSlot = $Margin/HBox/Control/EquipmentPanel/MarginContainer/EquipmentVBox/HBoxContainer2/EquipSlotNeck
@onready var equip_slot_body : EquipoSlot= $Margin/HBox/Control/EquipmentPanel/MarginContainer/EquipmentVBox/HBoxContainer3/EquipSlotBody
@onready var equip_slot_ring_1: EquipoSlot = $Margin/HBox/Control/EquipmentPanel/MarginContainer/EquipmentVBox/HBoxContainer3/EquipSlotRing1
@onready var equip_slot_pant: EquipoSlot = $Margin/HBox/Control/EquipmentPanel/MarginContainer/EquipmentVBox/HBoxContainer4/EquipSlotPant
@onready var equip_slot_ring_2: EquipoSlot = $Margin/HBox/Control/EquipmentPanel/MarginContainer/EquipmentVBox/HBoxContainer4/EquipSlotRing2
@onready var equip_slot_boots: EquipoSlot = $Margin/HBox/Control/EquipmentPanel/MarginContainer/EquipmentVBox/HBoxContainer5/EquipSlotBoots
@onready var equip_slot_belt: EquipoSlot = $Margin/HBox/Control/EquipmentPanel/MarginContainer/EquipmentVBox/HBoxContainer5/EquipSlotBelt

func _ready():
	#_populate_grid()
	#flow.resized.connect(_on_flow)
	#flow.resized.connect(_update_spacing_3)
	_populate_flow()
	_clear_details()
	#resized.connect(_update_spacing)
	close_button.pressed.connect(_on_close_button)
	action_button.pressed.connect(_on_action_button)
	#_update_spacing()
	_update_spacing_3()
	#_on_flow()
	set_active_filter_button(all_filter_button)
	
	#main_os.main_button_close.connect(_on_close_button)
	var main_os = get_tree().get_root().find_child("MainOS", true, false)
	if main_os:
		main_os.main_button_close.connect(_on_close_button)

func _populate_flow():
	for child in grid.get_children():
		child.queue_free()

	for data in items:
		var slot: ItemSlot = slot_scene.instantiate()
		slot.item_data = data
		slot.slot_clicked.connect(_on_slot_clicked)
		flow.add_child(slot)
	
	equip_slot_weapon.slot_clicked.connect(_on_slot_clicked)
	equip_slot_shield.slot_clicked.connect(_on_slot_clicked)
	equip_slot_helmet.slot_clicked.connect(_on_slot_clicked)
	equip_slot_neck.slot_clicked.connect(_on_slot_clicked)
	equip_slot_body.slot_clicked.connect(_on_slot_clicked)
	equip_slot_ring_1.slot_clicked.connect(_on_slot_clicked)
	equip_slot_pant.slot_clicked.connect(_on_slot_clicked)
	equip_slot_ring_2.slot_clicked.connect(_on_slot_clicked)
	equip_slot_boots.slot_clicked.connect(_on_slot_clicked)
	equip_slot_belt.slot_clicked.connect(_on_slot_clicked)

func _on_close_button():
	detail_panel_margin.hide()
	main_action_panel.hide()

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
	if item_data:
		_update_details(item_data)
		main_action_panel.hide()
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
	drop_button.disabled = not item.can_drop
	
	use_action_button.visible = item.can_use
	equip_action_button.visible = item.can_equip
	drop_action_button.visible = item.can_drop

func _on_flow():
	_update_spacing_2()

func _update_spacing_3():
	var container_width := flow.size.x
	if container_width <= 0:
		return

	var slot_w := slot_size.x

	# cuántos caben por fila
	var max_per_row = max(1, floori(container_width / (slot_w + min_spacing)))

	# ancho usado por items
	var used_width = max_per_row * slot_w

	# espacio libre entre items
	var free_space = container_width - used_width

	# spacing ideal
	var spacing := floori(free_space / (max_per_row + 1))

	# límite para que no se desarme la grilla
	spacing = clamp(spacing, min_spacing, 32)

	flow.add_theme_constant_override("h_separation", spacing)
	flow.add_theme_constant_override("v_separation", spacing)

func _on_action_button():
	main_action_panel.visible = !main_action_panel.visible

func set_active_filter_button(button: Button):
	# Primero desactivo todos
	all_filter_button.button_pressed = false
	all_filter_button.disabled = false
	equipments_filter_button.button_pressed = false
	equipments_filter_button.disabled = false
	consumables_filter_button.button_pressed = false
	consumables_filter_button.disabled = false
	resources_filter_button.button_pressed = false
	resources_filter_button.disabled = false

	# Activo solo el correcto
	button.button_pressed = true
	button.disabled = true

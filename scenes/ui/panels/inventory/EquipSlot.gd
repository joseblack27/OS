extends ItemSlot
class_name EquipoSlot

@export var icon: Texture2D:
	set(value):
		icon = value
		update_item()
@export var type_equippable: Enums.type_items_inventory_equippables = Enums.type_items_inventory_equippables.NONE

func update_item():
	if item_data:
		$Icon.texture = item_data.icon
	elif icon:
		$Icon.texture = icon
	else:
		$Icon.texture = null

func _can_drop_data(_position, data) -> bool:
	#if typeof(data) != TYPE_DICTIONARY:
		#return false
#
	#if not data.has("item"):
		#return false
#
	#var item: ItemData = data.item
#
	#if not item.can_equip:
		#return false
#
	#var valido = item.type_equippable == type_equippable
	#modulate = Color(.4,1,.4,1) if valido else Color(1,0.4,0.4,1)
#
	## Validar tipo de slot
	#return valido
	
	#if (data is ItemSlot or data is EquipoSlot):
		#return false
	if data.item_data == null:
		return false
	#if data.item_data.type == Enums.type_item_inventory.EQUIPPABLE:
		#return false
	if item_data and data.item_data.type_equippable != item_data.type_equippable:
		return false
	
	var valido = data.item_data.type_equippable == type_equippable
	modulate = Color(0,1,0,1) if valido else Color(1,0,0,1)
	
	return valido

func _drop_data(_position, data):
	if data == self:
		return
	
	var item: ItemData = data.item_data

	# Equipar
	item_data = item

	# Limpiar el slot origen
	if data:
		data.item_data = null
		data.call_deferred("queue_free")

	update_item()

func _notification(what):
	if what == NOTIFICATION_DRAG_END:
		modulate = Color(1,1,1,1)

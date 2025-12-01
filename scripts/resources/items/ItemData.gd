extends Resource
class_name ItemData

@export var name: String = ""
@export var icon: Texture2D
@export var quantity: int = 1

# Opcional para más adelante
@export var description: String = ""
@export var type: type_item = type_item.NONE:
	set(value):
		type = value
		type_descripcion = item_description[value]

@export var can_use: bool = false
@export var can_equip: bool = false

var type_descripcion: String

enum type_item {
	NONE,
	CONSUMABLE,
	EQUIPPABLE,
	RESOURCE,
	QUEST,
	WEAPON
}

const item_description := {
	type_item.NONE: "vacio",
	type_item.CONSUMABLE: "consumible",
	type_item.RESOURCE: "recurso",
	type_item.WEAPON: "arma",
	type_item.QUEST: "misión",
	type_item.EQUIPPABLE: "equipable"
}

extends Resource
class_name ItemData

@export var name: String = ""
@export var icon: Texture2D
@export var quantity: int = 1

# Opcional para más adelante
@export var description: String = ""
@export var type: Enums.type_item_inventory = Enums.type_item_inventory.NONE:
	set(value):
		type = value
		type_descripcion = item_description[value]

@export var can_use: bool = false
@export var can_equip: bool = false
@export var can_drop: bool = true

var type_descripcion: String

const item_description := {
	Enums.type_item_inventory.NONE: "vacio",
	Enums.type_item_inventory.ALL: "todos",
	Enums.type_item_inventory.CONSUMABLE: "consumible",
	Enums.type_item_inventory.RESOURCE: "recurso",
	Enums.type_item_inventory.WEAPON: "arma",
	Enums.type_item_inventory.QUEST: "misión",
	Enums.type_item_inventory.EQUIPPABLE: "equipable"
}

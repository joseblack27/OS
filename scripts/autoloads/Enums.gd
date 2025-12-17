extends Node

enum type_item_inventory {
	NONE,
	ALL,
	CONSUMABLE,
	EQUIPPABLE,
	RESOURCE,
	QUEST,
	WEAPON
}

enum type_items_inventory_equippables {
	NONE,
	HELMET,
	BODY,
	PANT,
	BOOTS,
	NECK,
	RING,
	BELT,
	WEAPON,
	SHIELD
}

enum color_damage {
	EARTH,
	FIRE,
	WATER,
	WIND
}

const color_damage_value := {
	color_damage.EARTH: "#905010",
	color_damage.FIRE: "red",
	color_damage.WATER: "#00c4ff",
	color_damage.WIND: "#008f39"
}

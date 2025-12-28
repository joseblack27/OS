extends Node

class Inventory:
	enum TypeItem {
		NONE,
		ALL,
		CONSUMABLE,
		EQUIPPABLE,
		RESOURCE,
		QUEST,
		WEAPON
	}

	enum TypeItemEquippable {
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

class Skill:
	enum TypeLaunch {
		PROYECTIL,
		AREA
	}
	
	enum ColorDamage {
		EARTH,
		FIRE,
		WATER,
		WIND
	}

	const color_damage_value := {
		ColorDamage.EARTH: "#905010",
		ColorDamage.FIRE: "red",
		ColorDamage.WATER: "#00c4ff",
		ColorDamage.WIND: "#008f39"
	}

class Event:
	enum Type {
		WORLD_BOSS,
		DUNGEON,
		INVASION,
		WORLD_CHANGE,
		FACTION
	}

	enum Status {
		UPCOMING,
		ACTIVE,
		COMPLETED,
		FAILED,
		CANCELLED
	}

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

class Mission:
	enum Type {
		HISTORIA,
		SECUNDARIA,
		EVENTO,
		DIARIA
	}

	enum Status {
		LOCKED,
		AVAILABLE,
		IN_PROGRESS,
		COMPLETED,
		FAILED
	}
	
	func _get_type_text(type: Mission.Type) -> String:
		match type:
			Mission.Type.HISTORIA: return "Historia"
			Mission.Type.SECUNDARIA: return "Secundaria"
			Mission.Type.EVENTO: return "Evento"
			Mission.Type.DIARIA: return "Diaria"
		return "-"

class ColorUI:
	enum UI {
		GREEN_FLUORESCENT,
		BACK_WHITE,
		LINE_WHITE
	}
	
	const color_ui_value := {
		UI.GREEN_FLUORESCENT: "38ff14",
		UI.BACK_WHITE: "f0f0f0",
		UI.LINE_WHITE: "eaeaea10"
	}

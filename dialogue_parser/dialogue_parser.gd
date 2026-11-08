@tool
class_name DialogueParser

@export var dialogue_ressource: Dictionary
var root: Dictionary
var current: Variant

func _init(ressource: Dictionary) -> void:
	dialogue_ressource = ressource
	root = _load_root_node()
	current = root

func get_node_from_data(id: String) -> Variant:
	var found_node: Dictionary
	if(id == "-1"):
		return -1
	for entry in dialogue_ressource:
		var node = dialogue_ressource.get(entry)
		if(node.id == id):
			found_node = node
	return found_node

func _load_root_node() -> Dictionary:
	var root_node: Dictionary
	for entry in dialogue_ressource:
		var node = dialogue_ressource.get(entry)
		if(node.has("isRoot")):
			root_node = node
	return root_node

func set_next_node(id: String = "") -> void:
	if(id.is_empty()):
		return
	else:
		current = get_node_from_data(id)

@tool
extends Node

@export var dialogue_ui: Control
var parser: DialogueParser

func start_conversation(scene: Dictionary) -> void:
	parser = DialogueParser.new(scene)
	#dialogue_ui.instantiate()

func end_conversation() -> void:
	dialogue_ui.queue_free()
	parser = null

func get_first_node() -> Dictionary:
	return parser.root

func get_next_node() -> Variant:
	var node = parser.current
	match node.type:
		"dialogue", "event":
			return _handle_next_node(node.next_node)
		"hub":
			return _hub_interactions(node.next_nodes)
		"jump":
			return _handle_next_node(node.target_node)
		"condition":
			return _pass_skill_check(node, false)
	return node

func _handle_next_node(next_node: Variant) -> Variant:
	var next = parser.get_node_from_data(next_node)
	if next_node == "-1":
		end_conversation()
		return -1
	match next.type:
		"dialogue", "event":
			parser.set_next_node(next.id)
			return next
		"hub":
			parser.set_next_node(next.id)
			return _hub_interactions(next.next_nodes)
		"jump":
			parser.set_next_node(next.target_node)
			return get_next_node()
		"condition":
			parser.set_next_node(next.id)
			return _pass_skill_check(next, false)
		_: return null

func get_dialogue_text_from_node(id: String) -> String:
	var node: Dictionary = parser.get_node_from_data(id)
	return node.dialogue_text

func user_input(id: String = "") -> Variant:
	parser.set_next_node(id)
	return get_next_node()

func get_current_type() -> String:
	if parser.current is Dictionary:
		return parser.current.type
	return "end"

func _hub_interactions(next_nodes: Array) -> Dictionary:
	var user_interactions: Dictionary
	for node in next_nodes:
		user_interactions[node] = parser.get_node_from_data(node)
	return user_interactions

func _pass_skill_check(next: Dictionary, result: bool) -> Variant:
	if(result):
		parser.set_next_node(next.next_node_after_success)
		return parser.get_node_from_data(next.next_node_after_success)
	else:
		parser.set_next_node(next.next_node_after_failure)
		return parser.get_node_from_data(next.next_node_after_failure)

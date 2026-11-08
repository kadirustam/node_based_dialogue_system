@tool
extends Panel

@export var condition_name: String
@export var condition_id: String
@export var condition_type: String
@export var condition_compare_value: String

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var drag_data: Dictionary = SceneViewGlobal.drag_data
			if not drag_data.is_empty():
				SceneViewGlobal.create_and_connect_condition_node(condition_name, condition_id, condition_type, condition_compare_value, drag_data.position, drag_data.from_node, drag_data.from_port)
			else:
				SceneViewGlobal.create_condition_node(condition_name, condition_id, condition_type, condition_compare_value)

func set_up_condition_node(name: String, id: String, type: String, compare_value: String) -> void:
	condition_name = name
	condition_id = id
	condition_type = type
	condition_compare_value = compare_value
	$ConditionLabel.text = condition_name

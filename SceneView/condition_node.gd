@tool
extends GraphNode

@export var node_id: String
@export var condition_name: String
@export var condition_id: String
@export var condition_type: String
@export var condition_compare_value: String


func set_up_node(n_id: String, name: String, id: String, type: String, compare_value: String) -> void:
	node_id = n_id
	condition_name = name
	condition_id = id
	_set_condition_type(type)
	_set_compare_value(compare_value)
	$ConditionEdit.text = name

func _set_condition_type(type: String) -> void:
	var group = $HBoxContainer/ActiveCheckBox.button_group.get_buttons()
	for button: Button in group:
		if button.text.to_lower() == type:
			condition_type = type
			button.button_pressed = true

func _set_compare_value(compare_value: String) -> void:
	condition_compare_value = compare_value
	$HBoxContainer2/TextEdit.text = condition_compare_value
	if !condition_compare_value.is_empty():
		$HBoxContainer2.visible = true

@tool
extends Panel

@export var condition_name: String
@export var condition_id: String
@export var condition_type: String
@export var condition_compare_value: String
var selected: bool = false


func set_up_condition(name: String, id: String, type: String, compare_value: String) -> void:
	condition_name = name
	condition_id = id
	condition_type = type
	condition_compare_value = compare_value
	$ConditionLabel.text = condition_name

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			ConditionMenuGlobal.set_selected_condition(self)

func toggle_selected() -> void:
	selected = !selected
	$SelectMarker.visible = selected

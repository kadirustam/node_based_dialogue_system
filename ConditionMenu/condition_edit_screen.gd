@tool
extends Control

@onready var name_edit = $Window/Panel/ConditionNameLabel/ConditionNameEdit
@onready var id_edit = $Window/Panel/ConditionIdLabel/ConditionIdEdit
@onready var compare_edit = $Window/Panel/Label/HBoxContainer/CompareEdit


func _on_window_close_requested() -> void:
	self.queue_free()


func _on_cancel_button_pressed() -> void:
	_on_window_close_requested()


func _on_create_button_pressed() -> void:
	if(name_edit.text.is_empty()):
		$EmptyNameDialog.popup()
		return
	if(id_edit.text.is_empty()):
		_on_generate_id_button_pressed()
	ConditionMenuGlobal.create_condition_item(name_edit.text, id_edit.text, _get_radio_button(), _get_compare_value())
	_on_window_close_requested()


func _on_generate_id_button_pressed() -> void:
	id_edit.text = ConditionMenuGlobal.generateId()

func _get_radio_button() -> String:
	var button: Button = $Window/Panel/Label/HBoxContainer/ActiveCheckBox.button_group.get_pressed_button()
	return button.text.to_lower()

func _on_compare_check_box_toggled(toggled_on: bool) -> void:
	compare_edit.clear()
	compare_edit.visible = !compare_edit.visible

func _get_compare_value() -> String:
	if $Window/Panel/Label/HBoxContainer/CompareCheckBox.button_pressed:
		return compare_edit.text
	else:
		return ""

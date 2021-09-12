extends CanvasLayer

signal start_game


func _on_Button_pressed():
	$GameOver.hide()
	$Button.hide()
	emit_signal("start_game")


func new_game():
	pass # Replace with function body.

func update_score(score):
	$Score.text = str(score)

func open_menu():
	if $Button.visible == true:
		$Button.hide()
	else:
		$Button.show()

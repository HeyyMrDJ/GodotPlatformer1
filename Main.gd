extends Node

func _ready():
	$music.play()
	$HUD/Button.hide()
	$HUD/Button.text = "Continue"
	$HUD/GameOver.hide()

func new_game():
	$HUD/Score.text = str(0)
	get_tree().reload_current_scene()
	#get_tree().change_scene("res://Main.tscn")

func game_over():
	$HUD/Button.show()
	$HUD/GameOver.show()
	$music.stop()
	$gameover_music.play()


func level_won():
	$music.stop()
	$you_won_music.play()
	$HUD/GameOver.text = "LEVEL COMPLETED!!!"
	$HUD/GameOver.show()
	print(get_tree().current_scene.name)
	print($"/root/Global".level)
	yield(get_tree().create_timer(6.0), "timeout")
	$HUD/Button.show()
	if $"/root/Global".level == 4:
		get_node("/root/Global").level = 0
		print("Current level is: ", get_node("/root/Global").level)
		$you_won_music.stop()
		$you_won_game_music.play()
		$HUD/Button.text = "New Game"
		$HUD/GameOver.text = "YOU HAVE SAVED THE CONQUERED THE BOSS AND IT'S MINIONS. THE WORLD IS NOW SAFE AGAIN!!!"
		yield(get_tree().create_timer(26.0), "timeout")
		$HUD/GameOver.show()
	get_node("/root/Global").level += 1
	get_tree().change_scene("res://level"+str(get_node("/root/Global").level)+".tscn")

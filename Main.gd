extends Node

func _ready():
	$music.play()
	$HUD/Button.hide()
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
		$HUD/GameOver.text = "YOU HAVE SAVED THE WORLD AND BEATEN THE GAME!!"
		yield(get_tree().create_timer(3.0), "timeout")
		$HUD/GameOver.show()
		get_tree().change_scene("res://level1.tscn")
	get_node("/root/Global").level += 1
	get_tree().change_scene("res://level"+str(get_node("/root/Global").level)+".tscn")
	#get_tree().change_scene("res://level2.tscn")

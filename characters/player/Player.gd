extends KinematicBody2D

export (int) var speed = 400
export (int) var jump_speed = -1200
export (int) var gravity = 4000

var state_machine

signal open_menu

var velocity = Vector2.ZERO

signal player_died
signal level_won

onready var _animation_player = $AnimationPlayer

func _ready():
	state_machine = $AnimationTree.get("parameters/playback")

func get_input():
	velocity.x = 0
	state_machine.travel("idle")
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
		state_machine.travel("walk")
		$Sprite.flip_h = false
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
		state_machine.travel("walk")
		$Sprite.flip_h = velocity.x < 0
	if Input.is_action_just_pressed("jump"):
		state_machine.travel("standing_jump")
		$jump_sound.play()
	if Input.is_action_just_pressed("attack1"):
		state_machine.travel("attack1")
		$attack.play()
	if Input.is_action_just_pressed("menu_open"):
		emit_signal("open_menu")

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed

# _animation_player.play("New Anim")


func _on_player_side_area_entered(_area):
	game_over()
	

func game_over():
	emit_signal("player_died")
	queue_free()


func _on_dead_zone_body_entered(_body):
	emit_signal("player_died")

func level_won():
	emit_signal("level_won")
	queue_free()


func _on_End_level_level_won():
	pass # Replace with function body.

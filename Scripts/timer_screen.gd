extends Node2D
@onready var broccoli_container: HBoxContainer = $BroccoliContainer
@onready var broccoli: TextureRect = $BroccoliContainer/Broccoli
@onready var broccoli_2: TextureRect = $BroccoliContainer/Broccoli2
@onready var broccoli_3: TextureRect = $BroccoliContainer/Broccoli3
@onready var broccoli_4: TextureRect = $BroccoliContainer/Broccoli4
@onready var broccoli_5: TextureRect = $BroccoliContainer/Broccoli5
@onready var level: RichTextLabel = $Level
@onready var timer: RichTextLabel = $Timer

var time = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await Timer(5.0)
	
	if Global.minigames_done < 3:
		Global.minigames_done += 1
		get_tree().change_scene_to_file("res://Scenes/minigame_" + str(Global.minigames_done) + ".tscn")
		
	else:
		get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match Global.lives:
		4:
			broccoli.hide()
		3:
			broccoli.hide()
			broccoli_2.hide()
		2:
			broccoli.hide()
			broccoli_2.hide()
			broccoli_3.hide()
		1:
			broccoli.hide()
			broccoli_2.hide()
			broccoli_3.hide()
			broccoli_4.hide()
		0:
			broccoli_container.hide()
	timer.text = str(time)
	level.text = "Level " + str(Global.minigames_done)
	
func Timer(start_time: float):
	time = start_time
	
	while time > 0.0:
		await wait(0.1)
		time -= 0.1
	return
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

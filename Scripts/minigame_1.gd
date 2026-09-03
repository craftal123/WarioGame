extends Node2D

@onready var colorsText: RichTextLabel = $colorsText
@onready var score_text: RichTextLabel = $scoreText
@onready var themed_timer: Node2D = $themed_timer

@onready var blue_timer: Timer = $BlueTube/BlueTimer
@onready var red_timer: Timer = $RedTube/RedTimer
@onready var green_timer: Timer = $GreenTube/GreenTimer
@onready var yellow_timer: Timer = $YellowTube/YellowTimer

var colors = ["BLUE","RED","GREEN","YELLOW"]
var colorsPicked = []
var correct = 0
var correctMix = 0
var timer_end = false
var can_hover_blue = true
var can_hover_red = true
var can_hover_green = true
var can_hover_yellow = true
@export var numberToCorrect = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pickRandColor()
	
	await themed_timer.Timer(25.0)
	
	timer_end = true

func _process(delta: float) -> void:
	if timer_end:
		Global.minigames_done -= 1
		Global.lives -= 1
		get_tree().change_scene_to_file("res://Scenes/level_scene.tscn")
	score_text.text = str(correctMix) + "/" + str(numberToCorrect)

func _on_blue_tube_mouse_entered() -> void:
	if can_hover_blue:
		print("blue entered")
		checkColor("BLUE")
		can_hover_blue = false
		blue_timer.start(1)
		
	


func _on_red_tube_mouse_entered() -> void:
	if can_hover_red:
		print("red entered")
		checkColor("RED")
		can_hover_red = false
		red_timer.start(1)


func _on_green_tube_mouse_entered() -> void:
	if can_hover_green:
		print("green entered")
		checkColor("GREEN")
		can_hover_green = false
		green_timer.start(1)


func _on_yellow_tube_mouse_entered() -> void:
	if can_hover_yellow:
		print("yellow entered")
		checkColor("YELLOW")
		can_hover_yellow = false
		yellow_timer.start(1)

func checkColor(color):
	if colorsPicked.has(color):
		correct+=1
		colorsPicked.erase(color)
	else:
		print("Wrong")
		Global.lives -= 1
		get_tree().change_scene_to_file("res://Scenes/level_scene.tscn")
		#correct = 0
		#pickRandColor()
	if correct == 2:
		print("Right")
		correctMix += 1
	if correct == 2:
		correct = 0
		pickRandColor()
		if correctMix > numberToCorrect:
			print("WIN")
			Global.minigames_done+=1
			get_tree().change_scene_to_file("res://Scenes/level_scene.tscn")
func pickRandColor():
	colorsPicked = []
	colorsPicked.append(colors.pick_random())
	colors.erase(colorsPicked[0])
	print(colors)
	colorsPicked.append(colors.pick_random())
	print(colorsPicked)
	colors = ["BLUE","RED","GREEN","YELLOW"]
	colorsText.text = colorsPicked[0] + " + " + colorsPicked[1]


func _on_blue_timer_timeout() -> void:
	can_hover_blue = true


func _on_red_timer_timeout() -> void:
	can_hover_red = true


func _on_green_timer_timeout() -> void:
	can_hover_green = true


func _on_yellow_timer_timeout() -> void:
	can_hover_yellow = true

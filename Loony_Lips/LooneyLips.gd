extends Control

var current_story = {
	"propmpt" : ["name","food","place"],
	"story" : "Once upon %s had %s in the %s and it was cold."	
}
var player_words = []

onready var DisplayText = $VBoxContainer/DisplayText
onready var PlayerText = $VBoxContainer/HBoxContainer/PlayerText

func _ready():
	DisplayText.text = "Welcome to this game. Lets tell a story:" 
	check_player_word_size()
	PlayerText.grab_focus()

func _on_PlayerText_text_entered(new_text):
	add_to_player_word()

func _on_TextureButton_pressed():
	if is_story_done():
		get_tree().reload_current_scene()
	else:	
		add_to_player_word()
	
func add_to_player_word():
	player_words.append(PlayerText.text)
	DisplayText.text = ""
	PlayerText.clear()
	check_player_word_size()
	
func is_story_done():
	return player_words.size() == current_story.propmpt.size()
	
func check_player_word_size():
	if is_story_done():
		end_game()
	elif not is_story_done():
		prompt_player()
	else:
		pass
		
		
func tell_story():
	DisplayText.text = current_story.story % player_words
	
func prompt_player():
	DisplayText.text += "May i have "+ current_story.propmpt[player_words.size()]+ " please?"
	
func end_game():
	PlayerText.queue_free()  
	$VBoxContainer/HBoxContainer/Label.text = "Again?"
	tell_story()
	

		

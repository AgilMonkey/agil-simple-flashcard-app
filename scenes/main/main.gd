extends Control

var flashcards = []
var current_card_index = 0

# Path to the JSON file
const JSON_FILE_PATH = "res://flashcards.json"

func _ready():
	load_flashcards()  # Load the flashcards from the JSON file
	show_question()    # Display the first flashcard's question

# Function to load flashcards from a JSON file
func load_flashcards():
	var file = FileAccess.open(JSON_FILE_PATH, FileAccess.READ)  # Open the file in read mode
	if file:
		var json = JSON.new()
		var json_string = file.get_as_text()  # Read the file contents as text
		var error = json.parse(json_string)

		if error == OK:
			flashcards = json.data  # Store the flashcards in the array
		else:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
	else:
		print("Failed to open file.")
	file.close()

# Function to display the current flashcard's question (in Korean)
func show_question():
	if flashcards.size() > 0:
		var question = flashcards[current_card_index]["question"]
		$"%FlashcardContainer"/FlashcardPanel/FlashcardLabel.text = question

# Function to show the answer (in Indonesian)
func show_flashcard():
	var answer = flashcards[current_card_index]["answer"]
	if $"%FlashcardContainer"/FlashcardPanel/FlashcardLabel.text == answer:
		answer = flashcards[current_card_index]["question"]
	$"%FlashcardContainer"/FlashcardPanel/FlashcardLabel.text = answer


# Function to show the next flashcard
func show_next_flashcard():
	# Increment the index to move to the next card
	var old_index = current_card_index
	current_card_index = randi_range(0, flashcards.size() - 1)  # get random card
	if current_card_index == old_index: current_card_index += 1 # Add 1 if it's the same card
	show_question()  # Show the next card's question


func _on_show_answer_button_pressed() -> void:
	show_flashcard()


func _on_next_button_pressed() -> void:
	show_next_flashcard()

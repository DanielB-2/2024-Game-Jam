extends Label

var textToType = """Main Scene:\nbuildaboat373\n\nShredder:\nbuildaboat373\n\nGuard Mechanics:\nDanielB-2\n\nSprite Design\nasthehourspass\n\nMusic Design:\nasthehourspass\n\nBackground Art:\nasthehourspass\n\nIntro Sequence:\nasthehourspass\n\nCrouching Mechanics:\n_galaga_1\n\n\n\n\n\nGoodbye.\n\nNow get back to work!\nVoid all the policies!\n!!!\n
"""
var lastIndexOnScreen = 0.0
var maxNumberOfLinesOnSceen = 7
var typingSpeed = 7

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lastIndexOnScreen += delta * typingSpeed;
	var lastIndex = round(lastIndexOnScreen)
	
	var textToDisplay = textToType.substr(0, lastIndex)
	
	var numberOfLines = textToDisplay.count("\n", 0, textToDisplay.length())
	
	if (numberOfLines>maxNumberOfLinesOnSceen):
		var firstLine = numberOfLines-maxNumberOfLinesOnSceen
		for i in range(firstLine):
			print(textToDisplay.find("\n"))
			textToDisplay = textToDisplay.substr(textToDisplay.find("\n")+1, textToDisplay.length())
	print(textToDisplay)
	self.text = textToDisplay
	print(numberOfLines)

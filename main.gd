extends Node2D

var playerDeck = null
var oponentDeck = null
var spitCondition = false

var cards = ["Card1", "Card2","Card3","Card4"]

# Called when the node enters the scene tree for the first time.
func _ready():
	init()
	pass

func makeDeck():
	var newDeck = []
	for suit in ["S","C","D","H"]:
		for rank in range(13):
			newDeck.append([suit,rank])
	newDeck.shuffle()
	return newDeck

func init():
	var deck = makeDeck()
	playerDeck = deck.slice(0,26,1)
	oponentDeck = deck.slice(26,52,1)
	#print("deck", deck)
	#print("playerDeck ", playerDeck.size(), playerDeck[0], playerDeck[-1])
	#print("oponentDeck ", oponentDeck.size(), oponentDeck[0], oponentDeck[-1])
	
	for i in range(1, 6):
		get_node("Card" + str(i)).setValue(playerDeck.pop_front())
		get_node("Card" + str(i)).visible = true
		
	for i in range(6, 11):
		get_node("Card" + str(i)).setValue(oponentDeck.pop_front())
		get_node("Card" + str(i)).visible = true
	updateCounter()

	#
	#print("playerDeck ", playerDeck.size(), playerDeck[0], playerDeck[-1])
	#print("oponentDeck ", oponentDeck.size(), oponentDeck[0], oponentDeck[-1])

func _process(_delta):
	checkSpitCondition()
	handleInputs()

func setCard(cardNode: Node):
	if(Input.is_action_pressed("ui_left") && ((abs($Card9.val[1] - cardNode.val[1]) == 1) || abs($Card9.val[1] - cardNode.val[1]) == 12)):
		$Card9.setValue(cardNode.val)
		cardNode.visible = false
	elif(Input.is_action_pressed("ui_right") && ((abs($Card10.val[1] - cardNode.val[1]) == 1) || abs($Card10.val[1] - cardNode.val[1]) == 12)):
		$Card10.setValue(cardNode.val)
		cardNode.visible = false

func handleInputs():
	for card in cards:
		if(Input.is_action_pressed("select" + card) && get_node(card).visible):
			get_node(card + "/Panel").visible = true
			setCard(get_node(card))
		else:
			get_node(card + "/Panel").visible = false
		
		if(Input.is_action_just_released("ui_up")):
			if(get_node(card).visible == false):
				if(playerDeck):
					get_node(card).setValue(playerDeck.pop_front())
					get_node(card).visible = true
					updateCounter()
					return
				else:
					#TODO: WIN CONDITION
					print("YOU WIN")
					pass


func _input(ev):
	if ev is InputEventKey and ev.pressed:
		if(Input.is_action_pressed("ui_down")):
			if(spitCondition):
				print("SPIT")
			else:
				print("NOT SPIT")
		# restart game
		if(ev.keycode == KEY_SPACE):
			init()

func checkSpitCondition():
	if($Card9.val[1]) == $Card10.val[1]:
		spitCondition = true
	else:
		spitCondition = false


func updateCounter():
	$PlayerCounter/CardCounter.set_text(str(playerDeck.size()))
	$CPUCounter/CardCounter.set_text(str(oponentDeck.size()))

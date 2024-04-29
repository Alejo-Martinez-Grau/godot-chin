extends Node2D

var playerDeck = null
var oponentDeck = null

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
	print("deck", deck)
	print("playerDeck ", playerDeck.size(), playerDeck[0], playerDeck[-1])
	print("oponentDeck ", oponentDeck.size(), oponentDeck[0], oponentDeck[-1])
	
	for i in range(1, 6):
		get_node("Card" + str(i)).setValue(playerDeck.pop_front())
		get_node("Card" + str(i)).visible = true
	for i in range(6, 11):
		get_node("Card" + str(i)).setValue(oponentDeck.pop_front())
		get_node("Card" + str(i)).visible = true
	
	print("playerDeck ", playerDeck.size(), playerDeck[0], playerDeck[-1])
	print("oponentDeck ", oponentDeck.size(), oponentDeck[0], oponentDeck[-1])

func _input(ev):
	if ev is InputEventKey and ev.pressed:
		if(ev.keycode == KEY_Q):
			$Card9.setValue(get_node("Card1").val)
			$Card1.visible = false
		if(ev.keycode == KEY_W):
			$Card9.setValue(get_node("Card2").val)
		if(ev.keycode == KEY_E):
			$Card10.setValue(get_node("Card3").val)
		if(ev.keycode == KEY_R):
			$Card10.setValue(get_node("Card4").val)
		# restart game
		if(ev.keycode == KEY_SPACE):
			init()

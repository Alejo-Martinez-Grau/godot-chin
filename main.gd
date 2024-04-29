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
	print("playerDeck", playerDeck)
	print("oponentDeck", oponentDeck)
	
	get_node("Card1").setValue(playerDeck.pop_front())
	get_node("Card2").setValue(playerDeck.pop_front())
	get_node("Card3").setValue(playerDeck.pop_front())
	get_node("Card4").setValue(playerDeck.pop_front())
	get_node("Card5").setValue(oponentDeck.pop_front())
	get_node("Card6").setValue(oponentDeck.pop_front())
	get_node("Card7").setValue(oponentDeck.pop_front())
	get_node("Card8").setValue(oponentDeck.pop_front())


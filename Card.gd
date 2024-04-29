extends Node2D

var val = null

# suit SDHC
# rank number 2-15
func setValue(suitRank: Array):
	val = suitRank
	print([val[0],val[1]+1])
	get_node("Spade").visible = false
	get_node("Diamond").visible = false
	get_node("Heart").visible = false
	get_node("Club").visible = false
	var active_card = null
	if(suitRank[0] == "S"):
		active_card = get_node("Spade")
	if(suitRank[0] == "D"):
		active_card = get_node("Diamond")
	if(suitRank[0] == "H"):
		active_card = get_node("Heart")
	if(suitRank[0] == "C"):
		active_card = get_node("Club")
	active_card.visible = true
	active_card.frame = suitRank[1]

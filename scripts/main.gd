extends Node2D

var counter = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _input(_event):
	pass


func _on_cat_pressed():
	$cat.add_body()
	pass # Replace with function body.

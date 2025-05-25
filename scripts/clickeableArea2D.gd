extends Area2D

# Señales personalizadas que actuarán como "puente"
signal received_mouse_click(event: InputEvent)
signal received_mouse_entered()
signal received_mouse_exited()

func _ready():
	# Conexión de las señales del Area2D
	input_event.connect(_on_input_event)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
	if event is InputEventMouseButton:
		received_mouse_click.emit(event)

func _on_mouse_entered():
	received_mouse_entered.emit()

func _on_mouse_exited():
	received_mouse_exited.emit()

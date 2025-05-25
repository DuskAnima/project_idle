extends TextureButton

@export var head_texture: Texture2D
@export var body_texture: Texture2D

# Variables para registrar las alturas de los Sprites2D.

var head_height := 16 
var body_height := 9 
var body_segments := 0 # Se asignará incrementalmente.

func _ready():
	# Configura texturas on ready
	$SpriteHead.texture = head_texture
	update_collision() # Calcula y actualiza tamaño del area del botón.
	var clickable_area = $Area2D
	clickable_area.received_mouse_click.connect(_handle_click)
	clickable_area.received_mouse_entered.connect(_handle_mouse_entered)
	clickable_area.received_mouse_exited.connect(_handle_mouse_exited)

# --- Funciónes para modificar botón y su hitbox ---
func add_body():
	var new_segment = Sprite2D.new() 
	var marker = $SpriteHead/Marker2D.position
	new_segment.texture = body_texture
	new_segment.position.x = marker.x 
	new_segment.position.y = marker.y + (body_height * body_segments)
	new_segment.centered = false
	add_child(new_segment)
	body_segments +=1
	update_collision()

func update_collision():
	var total_height = head_height + (body_height * body_segments) 
	_set_polygon_point_y(11, total_height)
	_set_polygon_point_y(12, total_height)

func _set_polygon_point_y(index: int, new_y: float) -> void:
	var polygon = $Area2D/CollisionPolygon2D.polygon
	
	if index < 0 or index >= polygon.size():
		push_error("Índice fuera de rango")
		return
	
	# Modifica SOLO el Y, manteniendo el X original
	polygon[index] = Vector2(polygon[index].x, new_y)
	
	$Area2D/CollisionPolygon2D.polygon = polygon # Actualiza la colisión

# --- Manejo de eventos ---
func _handle_click(event: InputEvent):
	if event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			print("Botón presionado (desde Area2D)")
			# Emite las señales que necesites
			button_down.emit()
		else:
			print("Botón liberado (desde Area2D)")
			pressed.emit()  # Señal nativa del botón

func _handle_mouse_entered():
	print("Mouse entró (desde Area2D)")
	mouse_entered.emit()
	modulate = Color(1.1, 1.1, 1.1)  # Efecto hover

func _handle_mouse_exited():
	print("Mouse salió (desde Area2D)")
	mouse_exited.emit()
	modulate = Color.WHITE

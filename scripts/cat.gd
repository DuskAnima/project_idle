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
	extend_polygon()

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
	var body_width = body_texture.get_width() 
	var marker = $SpriteHead/Marker2D.position
	#custom_minimum_size.y = total_height
	$Area2D/CollisionShape2D.shape.size.y = total_height
	$Area2D/CollisionShape2D.shape.size.x = body_width
	$Area2D/CollisionShape2D.position.y = int(marker.y + 8 + (body_height * body_segments) / 2.0)

func _get_polygon_marker(index: int) -> Vector2: # Función para obtener puntos del Polygon
	var polygon = $Area2D/CollisionPolygon2D.polygon
	if index < 0 or index >= polygon.size():
		push_error("Índice %d fuera de rango (el polígono tiene %d puntos)" % [index, polygon.size()])
		return Vector2.ZERO
	return polygon[index]  # Retorna el Vector2 del punto

func extend_polygon():
	var bot_left = _get_polygon_marker(11)
	var bot_right = _get_polygon_marker(12)
	print(bot_left)
	print(bot_right)

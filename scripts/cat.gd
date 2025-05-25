extends TextureButton

@export var head_texture: Texture2D
@export var body_texture: Texture2D

# Variables para registrar las alturas de los Sprites2D.

var head_height := 16 
var body_height := 9 
var body_segments := 1 # Se asignará incrementalmente.

func _ready():
	position_fixer()
	# Configura texturas on ready
	$SpriteHead.texture = head_texture
	$SpriteBody.texture = body_texture
	$Area2D/CollisionShape2D.shape = RectangleShape2D.new()
	update_collision() # Calcula y actualiza tamaño del area del botón.

"""
func _update_sprite_size():
	# Automatiza el tamaño real de las texturas (En caso de cambios en el sprite).
	# Asigna alto considerando la textura y su escala.
	head_height = head_texture.get_height() * $SpriteHead.scale.y 
	body_height = body_texture.get_height() * $SpriteBody.scale.y
"""
func add_body():
	var new_segment = Sprite2D.new() 
	new_segment.texture = body_texture
	new_segment.position.y = head_height + (body_height * body_segments)
	add_child(new_segment)
	body_segments +=1
	update_collision()

func position_fixer():
	pass
	
	

func update_collision():
	var total_height = head_height + (body_height * body_segments) 
	$Area2D/CollisionShape2D.shape.size.y = total_height
	#custom_minimum_size.y = total_height

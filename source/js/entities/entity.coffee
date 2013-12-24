class App.Entity
	constructor: (map) ->
		@map = map
		@x = 0
		@y = 0
		@width = 0
		@height = 0

	setSize: (w,h) ->
		@width = w
		@height = h

	setPosition: (x,y) ->
		@x = x
		@y = y

	check_collision: (shape) ->
		result = null
		vX = (@x + (@width / 2)) - (shape.x + (shape.width / 2))
		vY = (@y + (@height / 2)) - (shape.y + (shape.height / 2))
		halfWidth = (@width / 2) + (shape.width / 2)
		halfHeight = (@height / 2) + (shape.height / 2)
		if Math.abs(vX) < halfWidth and Math.abs(vY) < halfHeight
			oX = halfWidth - Math.abs(vX)
			oY = halfHeight - Math.abs(vY)
			if oX >= oY
				if vY > 0
					result = "bottom"
					#shape.y += oY
				else
					result = "top"
					#shape.y -= oY
			else
				if vX > 0
					result = "left"
					#shape.x += oX
				else
					result = "right"
					#shape.x -= oX

		return result

	render: (context) ->

	update: (deltaTime) ->






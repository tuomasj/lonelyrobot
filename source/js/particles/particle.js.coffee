class App.Particle
	constructor: (x, y, vx, vy) ->
		@x = x
		@y = y
		@r = Math.round(Math.random()*1)+1
		@velocity_x = vx || 0
		@velocity_y = vy || 0
		@max_age = Math.random(40) + 40
		@age = @max_age * 1.0
		@red = 255
		@green = Math.round(Math.random()*255)
		@blue = Math.floor(Math.random()*10)

	update: (deltaTime) ->
		@x += @velocity_x * deltaTime
		@y += @velocity_y * deltaTime

		@velocity_y += deltaTime * 0.5
		@age -= deltaTime
		return @age > 0

	render: (context) ->
		o = (1.0 - ((@max_age - @age) / @max_age)).toFixed(3)
		context.beginPath()
		context.fillStyle = "rgba(#{@red},#{@green},#{@blue},#{o})"
		context.arc(@x, @y, @r, 0, Math.PI*2, true)
		context.fill()
		context.closePath()


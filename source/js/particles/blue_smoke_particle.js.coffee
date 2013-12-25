class App.BlueSmokeParticle
	constructor: (x, y, vx, vy) ->
		@x = x
		@y = y
		@r = Math.round(Math.random()*3)+1
		@velocity_x = vx || 0
		@velocity_y = vy || 0
		@max_age = Math.random(30) + 30
		@age = @max_age * 1.0
		@red = 64
		@green = Math.round(Math.random()*128)+64
		@blue = Math.floor(Math.random()*128)+127
		@gravity = (Math.random() * 0.05)+0.05

	update: (deltaTime) ->
		@x += @velocity_x * deltaTime
		@y += @velocity_y * deltaTime

		@velocity_y += deltaTime * @gravity
		@age -= deltaTime
		return @age > 0

	render: (context) ->
		o = (1.0 - ((@max_age - @age) / @max_age)).toFixed(3)
		context.beginPath()
		context.fillStyle = "rgba(#{@red},#{@green},#{@blue},#{o / 2})"
		context.arc(@x, @y, @r*2, 0, Math.PI*2, true)
		context.fill()
		context.closePath()
		context.beginPath()
		context.fillStyle = "rgba(#{@red},#{@green},#{@blue},#{o})"
		context.arc(@x, @y, @r, 0, Math.PI*2, true)
		context.fill()
		context.closePath()


class App.ParticleEmitters.RedVolcano
	constructor: (particle_container, x,y) ->
		@particle_container = particle_container
		@counter = Math.floor(Math.random() * 2) + 5
		@x = x
		@y = y

	update: (deltaTime) ->
		@counter -= deltaTime
		if @counter < 0
			@emit_particle(@x,@y)
			@counter = Math.floor(Math.random() * 15) + 10

	render: (context) ->


	emit_particle: (x,y) ->
		speed = Math.random()*1.5
		@particle_container.add( new App.Particle(x,y, (Math.random() * 1)-0.5 * speed, -4.5 - speed))
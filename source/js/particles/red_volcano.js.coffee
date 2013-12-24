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
			@counter = Math.floor(Math.random() * 5) + 1

	render: (context) ->


	emit_particle: (x,y) ->
		speed = Math.random(4) * 2
		@particle_container.add( new App.Particle(x,y, (Math.random() * 1)-0.5 * speed, -5*speed))
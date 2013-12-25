#= require 'particles/blue_smoke_particle.js'

class App.ParticleEmitters.BlueSmoke
	constructor: (particle_container, x,y) ->
		@particle_container = particle_container
		@counter = Math.floor(Math.random() * 10) + 5
		@x = x
		@y = y

	update: (deltaTime) ->
		@counter -= deltaTime
		if @counter < 0
			@emit_particle(@x,@y)
			@counter = Math.floor(Math.random() * 15) + 5

	render: (context) ->


	emit_particle: (x,y) ->
		speed = (Math.random() * 2)+1
		@particle_container.add( new App.BlueSmokeParticle(x,y, (Math.random()-0.5)* speed, -1*speed))
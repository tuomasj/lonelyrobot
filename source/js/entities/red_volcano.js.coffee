#= require 'particles/particle.js'
#= require 'particles/red_volcano.js'

class App.NPC.RedVolcano extends App.Sprite
	constructor: (map, res, particle_container,x,y) ->
		super(map, res)
		@setPosition(x,y)
		@setSize(16,16)
		@particle_container = particle_container
		@frames = {
			"idle": [ [32, 4], [33, 1], [34, 0.8], [32, 6], [33, 0.4], [34, 0.4]]
		}
		@start_animation("idle")
		@emitter = new App.ParticleEmitters.RedVolcano( particle_container, @x + 8, @y + 8 )

	update: (deltaTime) ->
		super(deltaTime)
		@emitter.update(deltaTime)


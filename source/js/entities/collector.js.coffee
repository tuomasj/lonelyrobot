class App.NPC.Collector extends App.Sprite
	constructor: (map, res, x, y, particles) ->
		debug "Collector.constructor(particles: #{particles} x:#{x} y:#{y}"
		super(map,res);
		@setPosition(x,y)
		@setSize(16,16)
		@particles = particles
		@grace_period = 10
		@ore_counter = 0
		@frames = {
								working: [ [41, 2], [42, 20]  ],
								broken: [ [42, 10], [40, 1], [42, 2], [40,1]],
								collect: [ [41, 1], [42, 1], [41, 1], [42, 1],[41, 1],[42, 5], [-2, "working"] ],
								full: [[ 41, 1], [41, 1]]
							}
		@start_animation("working")

	update: (deltaTime) ->
		super(deltaTime)
		if @ore_counter < 25
			if @grace_period >= 0
				@grace_period -= deltaTime
			if @grace_period < 0
				shape = {
					x: @x + 2,
					y: @y + 3,
					width: @width - 3,
					height: @height - 3
				}
				if @particles.falling_particles_collides_with_entity(shape)
					@start_animation('collect')
					@grace_period = 3
					@ore_counter += 1
					if @ore_counter >= 20
						@start_animation("full")

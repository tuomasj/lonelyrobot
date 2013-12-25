class App.NPC.Collector extends App.Sprite
	constructor: (map, res, x, y, particles) ->
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
					debug "- grace_period: #{@grace_period}"
					if @particles.collides_with_entity(this)
						@start_animation('collect')
						@grace_period = Math.round(Math.random() * 10) + 30
						debug "- set grace_period: #{@grace_period}"
						@ore_counter += 1
						debug "- ore_counter: #{@ore_counter}"
						if @ore_counter >= 25
							@start_animation("full")
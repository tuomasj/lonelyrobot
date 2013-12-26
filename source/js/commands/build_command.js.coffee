#= require 'commands/command.js'

class App.Commands.BuildCommand extends App.Command
	constructor: (entity, params) ->
		super(entity)
		@entity = entity
		@start_timer = params.timer
		@particles = params.particles
		@timer = 0

	process: (deltaTime) ->
		@timer -= deltaTime
		if @timer < 0
			if @state == "stand"
				@entity.stop_animation()
				@entity.drop_collector(@particles)
				return true
		if @timer < 0
				if @state == "build"
					@state = "stand"
					@timer = 5
					if @entity.direction == "left"
						@entity.start_animation("stand_up_left")
					else
						if @entity.direction == "right"
							@entity.start_animation("stand_up_right")
					
		return false

	start: ->
		@timer = @start_timer
		@state = "build"
		if @entity.direction == "left"
			@entity.start_animation("build_left")
		else
			if @entity.direction == "right"
				@entity.start_animation("build_right")


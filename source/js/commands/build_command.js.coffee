#= require 'commands/command.js'

class App.Commands.BuildCommand extends App.Command
	constructor: (entity, params) ->
		super(entity)
		@entity = entity
		@start_timer = params.timer
		@timer = 0

	process: (deltaTime) ->
		@timer -= deltaTime
		if @timer < 0
			if @state == "stand"
				debug("- command done")
				@entity.stop_animation()
				@entity.drop_collector()
				return true
		if @timer < 0
				if @state == "build"
					@state = "stand"
					if @direction == "left"
						@entity.start_animation("stand_up_left")
					else
						if @direction == "right"
							@entity.start_animation("stand_up_right")
					@timer = 4
		return false

	start: ->
		debug "BuildCommand.start()"
		@timer = @start_timer
		@state = "build"
		if @entity.direction == "left"
			@entity.start_animation("build_left")
		else
			if @entity.direction == "right"
				@entity.start_animation("build_right")


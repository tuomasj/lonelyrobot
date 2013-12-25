#= require 'commands/command.js'

class App.Commands.BuildCommand extends App.Command
	constructor: (entity, params) ->
		super(entity)
		@entity = entity
		@start_timer = params.timer
		console.log params
		@timer = 0

	process: (deltaTime) ->
		@timer -= deltaTime
		if @timer < 0
			if @state == "stand"
				@entity.stop_animation()
				return true
		if @timer < 0
				if @state == "build"
					@state = "stand"
					if @entity.idle_frame == 0
						@entity.start_animation("stand_up_left")
					else
						if @entity.idle_frame == 16
							@entity.start_animation("stand_up_right")
					@timer = 4
		return false

	start: ->
		@timer = @start_timer
		@state = "build"
		if @entity.idle_frame == 0
			@entity.start_animation("build_left")
		else
			if @entity.idle_frame == 16
				@entity.start_animation("build_right")


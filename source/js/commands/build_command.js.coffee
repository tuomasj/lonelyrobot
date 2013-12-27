#= require 'commands/command.js'

class App.Commands.BuildCommand extends App.Command
	constructor: (entity, params) ->
		super(entity)
		@entity = entity
		@start_timer = params.timer
		@particles = params.particles
		@timer = 0
		@obj_x = @x
		@obj_y = @y

	process: (deltaTime) ->
		@timer -= deltaTime
		if @timer < 0
			if @state == "stand"
				@entity.stop_animation()
				@entity.drop_collector(@obj_x, @obj_y, @particles)
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
		# can it be built?
		res = @entity.where_can_build()
		if res != false
			@start_building(res.x, res.y)
		else
			debug "Cannot build at (#{@entity.x}, #{@entity.y})", ERROR

	start_building: (x,y) ->
		debug "BuildCommand.start_building(x:#{x}, y:#{y})"
		@obj_x = x
		@obj_y = y
		@state = "build"
		if @entity.direction == "left"
			@entity.start_animation("build_left")
		else
			if @entity.direction == "right"
				@entity.start_animation("build_right")		

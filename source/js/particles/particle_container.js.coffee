class App.ParticleContainer
	constructor: (map) ->
		@map = map
		@particles = []

	add: (particle) ->
		@particles.push(particle)

	update: (deltaTime) ->
		len = @particles.length
		if len > 0
			for i in [len-1..0]
				p = @particles[i]
				if @collides_with_map(@map.tiles, p)
					@particles.remove(i)
					continue
				if not p.update(deltaTime)
					@particles.remove( i )	


	render: (context) ->
		for particle in @particles
			particle.render(context)

	collides_with_map: (tiles, particle) ->
		for tile in tiles
			if @check_collision(particle, tile)
				return true
		return false

	falling_particles_collides_with_entity: (entity) ->
		len = @particles.length
		result = false
		if len > 0
			for i in [len-1..0]
				p = @particles[i]
				if p.velocity_y > 0
					if @check_collision(p, entity )
						@particles.remove(i)
						result = true
		return result

	clamp: (value, min, max) ->
		if value > max
			return max
		if value < min
			return min
		return value

	check_collision: (circle, rect) ->
		#debug_clear()
		#debug "check_collision( x:#{circle.x}, y:#{circle.y}, r:#{circle.r})"
		#debug " - rect: #{rect.x}, #{rect.y}, #{rect.x + rect.width}, #{rect.y + rect.height}"
		closest_x = @clamp(circle.x, rect.x, rect.x + rect.width)
		closest_y = @clamp(circle.y, rect.y, rect.y + rect.height)
		#debug "- closest_x: #{closest_x} closest_y: #{closest_y}"
		if circle.x == closest_x
			dist_x = 0
		else
			dist_x = circle.x - closest_x
		if circle.y == closest_y
			dist_y = 0
		else
			dist_y = circle.y - closest_y
		#debug "- dist_x: #{dist_x}  dist_y: #{dist_y}"
		dist_sq = (dist_x * dist_x) + (dist_y * dist_y)
		#debug "  dist_sq: (#{dist_sq}) < circle.r*circle.r (#{circle.r*circle.r})"
		result = dist_sq < (circle.r * circle.r)
		#debug "- result: #{result}"
		return result


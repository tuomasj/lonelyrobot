class App.EntityContainer
  constructor: ->
    @entities = []
  add: (entity) ->
    @entities.push(entity)
  render: (context) ->
    for entity in @entities
      entity.render(context)
  update: (deltaTime) ->
    for entity in @entities
      entity.update(deltaTime)
  length: ->
    return @entities.length
  collides_with: (entity) ->
    for npc in @entities
      if npc.check_collision(entity)
        return true
    return false

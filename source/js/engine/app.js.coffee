window.App = {
  Commands: { },
  ParticleEmitters: { }
}
window.game = {}
window.ERROR = 1
window.SUCCESS = 2
window.TILE_SIZE_IN_PIXELS = 16
window.SPRITE_SIZE_IN_PIXELS = 12
window.debug_ctx = null

# Array Remove - By John Resig (MIT Licensed)
Array::remove = (from, to) ->
  rest = @slice((to or from) + 1 or @length)
  @length = (if from < 0 then @length + from else from)
  @push.apply this, rest
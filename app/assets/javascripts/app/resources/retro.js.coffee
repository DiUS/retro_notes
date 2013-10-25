app.factory "Retro", ($resource, API_PREFIX) ->
  $resource( API_PREFIX + "/retros/:id", 
    id: "@_id"
  ,
    update:
      method: "PUT"
  )

app.factory "RetroService", ($rootScope, RetroSession) ->
  retro: {}
  get: (retro_id) ->
    self = @
    Retro.get
      id: retro_id

      # Success
    , (response) ->
      self.retro = response.retro
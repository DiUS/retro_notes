app.factory "Retro", ['$resource', 'API_PREFIX', ($resource, API_PREFIX) ->
  $resource( API_PREFIX + "/retros/:id",
    id: "@_id"
  ,
    update:
      method: "PUT"
  )
]
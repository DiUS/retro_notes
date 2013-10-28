app.factory "Retro", ['$resource', 'API_PREFIX', ($resource, API_PREFIX) ->
  $resource( API_PREFIX + "/retro/:id",
    id: "@_id"
  ,
    update:
      method: "PUT"
  )
]
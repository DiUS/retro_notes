app.factory "Project", ['$resource', 'API_PREFIX', ($resource, API_PREFIX) ->
  $resource( API_PREFIX + "/projects/:id",
    id: "@id"
  ,
    update:
      method: "PUT"
  )
]
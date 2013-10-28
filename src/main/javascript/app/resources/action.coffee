app.factory "Action", ['$resource', 'API_PREFIX', ($resource, API_PREFIX) ->
  $resource( API_PREFIX + "/action/:action_id",
    action_id: "@action_id"
  ,
    query:
      method: 'GET',
      isArray: false

    update:
      method: "PUT"
  )
]
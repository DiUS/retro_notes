app.factory "Action", ['$resource', 'API_PREFIX', ($resource, API_PREFIX) ->
  $resource( API_PREFIX + "/actions/:action_id",
    action_id: "@action_id"
  ,
    query:
      method: 'GET',
      isArray: false

    update:
      method: "PUT"
  )
]
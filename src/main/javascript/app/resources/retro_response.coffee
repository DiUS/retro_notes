app.factory "RetroResponse", ['$resource', 'API_PREFIX', ($resource, API_PREFIX) ->
  $resource( API_PREFIX + "/retro_responses/:retro_response_id",
    retro_response_id: "@retro_response_id"
  ,
    query:
      method: 'GET',
      isArray: false
  )
]
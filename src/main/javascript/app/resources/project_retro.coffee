app.factory "ProjectRetro", ['$resource', 'API_PREFIX', ($resource, API_PREFIX) ->
  $resource( API_PREFIX + "/projects/:project_id/retros/:retro_id",
    project_id: "@project_id"
    retro_id: "@retro_id"
  ,
    query:
      method: 'GET',
      isArray: false
  )
]
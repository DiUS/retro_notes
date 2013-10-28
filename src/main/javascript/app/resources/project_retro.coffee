app.factory "ProjectRetro", ['$resource', 'API_PREFIX', ($resource, API_PREFIX) ->
  $resource( API_PREFIX + "/project/:project_id/retro/:retro_id",
    project_id: "@project_id"
    retro_id: "@retro_id"
  ,
    query:
      method: 'GET',
      isArray: false
  )
]
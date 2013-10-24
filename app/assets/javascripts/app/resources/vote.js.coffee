app.factory "Vote", ($resource, API_PREFIX) ->
  $resource( API_PREFIX + "retro_responses/:id/votes/:vote_id", 
    id: "@id"
  ,
    update:
      method: "PUT"
  )
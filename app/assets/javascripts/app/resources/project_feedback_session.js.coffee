app.factory "ProjectFeedbackSession", ($resource, API_PREFIX) ->
  $resource( API_PREFIX + "/projects/:project_id/feedback_sessions/:feedback_session_id", 
    project_id: "@project_id"
    feedback_session_id: "@feedback_session_id"
  ,
    query:
      method: 'GET',
      isArray: false
  )
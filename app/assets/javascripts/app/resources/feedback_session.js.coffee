app.factory "FeedbackSession", ($resource, API_PREFIX) ->
  $resource( API_PREFIX + "/feedback_sessions/:id", 
    id: "@_id"
  ,
    update:
      method: "PUT"
  )

app.factory "FeedbackSessionService", ($rootScope, FeedbackSession) ->
  feedback_session: {}
  get: (feedback_session_id) ->
    self = @
    FeedbackSession.get
      id: feedback_session_id

      # Success
    , (response) ->
      self.feedback_session = response.feedback_session
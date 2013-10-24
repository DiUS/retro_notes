app.controller "ProjectFeedbackSessionsController", ($scope, $http, $location, $state, $stateParams, $timeout,Page, Project, ProjectFeedbackSession, FeedbackSession, RetroResponse) ->
  # =========================================================================
  # Initialize
  # =========================================================================

  $scope.project = {}
  $scope.feedback_session = {}
  $scope.feedback_sessions = {}
  # $scope.new_retro_response = {}

  # =========================================================================
  # New
  # =========================================================================
  if $state.current.name.indexOf('default.projects.show.feedback_sessions.new') > -1
    Project.get
      id: $stateParams['project_id']

      # Success
    , (response) ->
      $scope.project = response

      # Error
    , (response) ->
      console.log 'error'

    ProjectFeedbackSession.query(
      project_id: $stateParams['project_id']

      # Success
    , (response) ->
      $scope.feedback_sessions = response

      # Error
    , (response) ->
    )
    Page.setTitle('New session')


  # =========================================================================
  # Show
  # =========================================================================
  if $state.current.name.indexOf('default.projects.show.feedback_sessions.show') > -1    
    Project.get
      id: $stateParams['project_id']

      # Success
    , (response) ->
      $scope.project = response

      # Error
    , (response) ->
      console.log 'error'

    FeedbackSession.get(
      id: $stateParams['feedback_session_id']

      # Success
    , (response) ->
      $scope.feedback_session = response.feedback_session
      $scope.feedback_session_copy = angular.copy($scope.feedback_session)
      Page.setTitle($scope.feedback_session.title)


      # Error
    , (response) ->
    )

    # Poll for changes
    (tick = ->
      FeedbackSession.get(
        id: $stateParams['feedback_session_id']
      , (response) ->
        $scope.feedback_session = response.feedback_session
        $timeout tick, 50000
      )
    )()


  # =========================================================================
  # Create
  # =========================================================================

  $scope.create = ->
    form_data = $scope.feedback_session
    FeedbackSession.save(
      project_id: $stateParams['project_id'],
      feedback_session: form_data

      # Success
    , (feedback_session) ->
      $location.path "/projects/#{$stateParams['project_id']}/feedback_sessions/#{feedback_session._id}"

      # Error
    , (response) ->
    )
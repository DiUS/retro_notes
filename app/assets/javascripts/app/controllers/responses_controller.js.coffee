app.controller "ResponsesController", ($scope, $http, $location, $state, $stateParams, Page, FeedbackSession, RetroResponse) ->
  # =========================================================================
  # Initialize
  # =========================================================================

  # $scope.responses = {}
  # $scope.response = {}
  $scope.new_retro_response = {}

  # =========================================================================
  # Create
  # =========================================================================

  $scope.create = (retro_reflection_id) ->
    form_data = $scope.new_retro_response
    RetroResponse.save(
      retro_reflection_id: retro_reflection_id,
      retro_response: form_data

      # Success
    , (response) ->
      $scope.new_retro_response = {}

      i = 0
      retro_response = response
      while i < $scope.feedback_session.retro_reflections.length
        if  $scope.feedback_session.retro_reflections[i]._id is retro_response.retro_reflection_id
          $scope.feedback_session.retro_reflections[i].retro_responses.push retro_response
          break
        i++

      $location.path "/projects/#{$stateParams['project_id']}/feedback_sessions/#{$scope.feedback_session._id}"

      # Error
    , (response) ->
    )
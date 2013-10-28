app.controller "ActionsController", ['$scope', '$http', '$location', '$state', '$stateParams', 'Page', 'Retro', 'Action', ($scope, $http, $location, $state, $stateParams, Page, Retro, Action) ->
  # =========================================================================
  # Initialize
  # =========================================================================

  $scope.new_retro_action = {}

  # =========================================================================
  # Create
  # =========================================================================

  $scope.create = (retro_reflection_id) ->
    form_data = $scope.new_retro_action
    Action.save(
      retro_reflection_id: retro_reflection_id,
      retro_action: form_data

      # Success
    , (action) ->
      actions_length = $scope.retro.actions.length
      $scope.retro.actions[actions_length] = action


      # i = 0
      # retro_action = action
      # while i < $scope.retro.retro_reflections.length
      #   if  $scope.retro.retro_reflections[i]._id is retro_action.retro_reflection_id
      #     $scope.retro.retro_reflections[i].retro_actions.push retro_action
      #     break
      #   i++

      $location.path "/projects/#{$stateParams['project_id']}/retros/#{$scope.retro._id}"

      # Error
    , (action) ->
    )
]
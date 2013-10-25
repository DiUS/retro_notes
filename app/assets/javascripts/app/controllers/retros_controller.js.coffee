app.controller "RetrosController", ($scope, $http, $location, $state, $stateParams, $timeout,Page, Project, Retro, RetroResponse) ->
  # =========================================================================
  # Initialize
  # =========================================================================

  $scope.project = {}
  $scope.retro = {}
  $scope.retros = {}
  # $scope.new_retro_response = {}

  # =========================================================================
  # New
  # =========================================================================
  if $state.current.name.indexOf('default.projects.show.retro.new') > -1
    Project.get
      id: $stateParams['project_id']

      # Success
    , (response) ->
      $scope.project = response

      # Error
    , (response) ->
      console.log 'error'

    Retro.query(
      project_id: $stateParams['project_id']

      # Success
    , (response) ->
      $scope.retros = response

      # Error
    , (response) ->
    )
    Page.setTitle('New retro')


  # =========================================================================
  # Show
  # =========================================================================
  if $state.current.name.indexOf('default.projects.show.retro.show') > -1    
    Project.get
      id: $stateParams['project_id']

      # Success
    , (response) ->
      $scope.project = response

      # Error
    , (response) ->
      console.log 'error'

    Retro.get(
      id: $stateParams['retro_id']

      # Success
    , (response) ->
      $scope.retro = response.retro
      $scope.retro_copy = angular.copy($scope.retro)
      Page.setTitle($scope.retro.title)


      # Error
    , (response) ->
    )

    # Poll for changes
    (tick = ->
      Retro.get(
        id: $stateParams['retro_id']
      , (response) ->
        $scope.retro = response.retro
        $timeout tick, 50000
      )
    )()


  # =========================================================================
  # Create
  # =========================================================================

  $scope.create = ->
    form_data = $scope.retro
    Retro.save(
      project_id: $stateParams['project_id'],
      retro: form_data

      # Success
    , (retro) ->
      console.log('here')
      $location.path "/projects/#{$stateParams['project_id']}/retros/#{retro._id}"

      # Error
    , (response) ->
    )
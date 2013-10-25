app.controller "ProjectsController", ($scope, $http, $location, $state, $stateParams, Page, Project, ProjectRetro, Retro) ->
  # =========================================================================
  # Initialize
  # =========================================================================

  $scope.projects = {}
  $scope.project = {}

  if $state.current.name == 'default.projects'
    Project.query(
      {}
      
      # Success
    , (response) ->
      $scope.projects = response

      # Error
    , (response) ->
    )

  # =========================================================================
  # Show
  # =========================================================================
  if $state.current.name == 'default.projects.show'
    Project.get
      id: $stateParams['project_id']

      # Success
    , (response) ->
      $scope.project = response

      # Error
    , (response) ->
      $state.transitionTo('default.projects')

    ProjectRetro.query(
      project_id: $stateParams['project_id']

      # Success
    , (response) ->
      $scope.retros = response.retros

      # Error
    , (response) ->
    )
    Page.setTitle('Show project')

  # =========================================================================
  # Create
  # =========================================================================

  $scope.create = ->
    Project.save(
      {}
    , project:
        title: $scope.project.title
        description: $scope.project.description

      # Success
    , (response) ->
      $location.path "/projects"

      # Error
    , (response) ->
    )

  # =========================================================================
  # Update
  # =========================================================================

  if $state.current.name == 'default.projects.edit'
    Project.get
      id: $stateParams['project_id']

      # Success
    , (response) ->
      $scope.project = response

      # Error
    , (response) ->

  $scope.update = ->
    Project.update
      id: $stateParams['project_id']
    , project:
        title: $scope.project.title
        description: $scope.project.description

      # Success
    , (response) ->
      $location.path "/projects"

      # Error
    , (response) ->

  # =========================================================================
  # Destroy
  # =========================================================================

  $scope.destroy = (id) ->
    Project.delete
      id: id

      # Success
    , (response) ->
      i = 0
      while i < $scope.projects.length
        if $scope.projects[i]['id'] is id
          $scope.projects.splice(i,1)
        i++

      # Error
    , (response) ->

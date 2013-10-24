app.controller "EventsController", ($scope, $http, $location, $state, $stateParams, Page) ->
  console.log AppRoutes.api_events_path()
  # =========================================================================
  # Initialize
  # =========================================================================
  $scope.events = {}
  if $state.current.name == 'events'
    $http.get("/api/events"

    # success
    ).then ((response) ->
      $scope.events = response.data
      Page.setTitle('title1')
    # failure
    ), (error) ->

  $scope.event = {}
  if $state.current.name == 'edit'
    $http.get("/api/events/#{$stateParams['id']}"

    # success
    ).then ((response) ->
      $scope.event = response.data

    # failure
    ), (error) ->

  # =========================================================================
  # Create
  # =========================================================================

  $scope.create = ->
    $http.post("/api/events",
      event:
        title: $scope.event.title
        description: $scope.event.description

    # success
    ).then ((response) ->
      $location.path "/events"

    # failure
    ), (error) ->

  # =========================================================================
  # Update
  # =========================================================================

  $scope.update = ->
    $http.put("/api/events/#{$scope.event._id}",
      event:
        title: $scope.event.title
        description: $scope.event.description

    # success
    ).then ((response) ->
      $location.path "/events"

    # failure
    ), (error) ->

  # =========================================================================
  # Destroy
  # =========================================================================

  $scope.destroy = (id) ->
    $http.delete("/api/events/#{id}"

    # success
    ).then ((response) ->
      $http.get("/api/events").then ((response) ->
        $scope.events = response.data
      ), (error) ->

    # failure
    ), (error) ->

  return false
app.controller("RetrosController", function ($scope, $http, $location, $state, $stateParams, $timeout, Page, Project, Retro, RetroResponse, Action) {
  var tick;

  $scope.project = {};
  $scope.retro = {};
  $scope.retros = {};
  if ($state.current.name.indexOf('default.projects.show.retro.new') > -1) {
    Project.get({
      id: $stateParams['project_id']
    }, function (response) {
      return $scope.project = response;
    }, function (response) {
      return console.log('error');
    });
    Retro.query({
      project_id: $stateParams['project_id']
    }, function (response) {
      return $scope.retros = response;
    }, function (response) {
    });
    Page.setTitle('New retro');
  }
  if ($state.current.name.indexOf('default.projects.show.retros.show') > -1) {
    Project.get({
      id: $stateParams['project_id']
    }, function (response) {
      return $scope.project = response;
    }, function (response) {
      return console.log('error');
    });
    Retro.get({
      id: $stateParams['retro_id']
    }, function (response) {
      $scope.retro = response.retro;
      return Page.setTitle($scope.retro.title);
    }, function (response) {
    });
    $scope.resolve_action = function (retro_action) {
      return Action.update(retro_action, {
        action_id: retro_action._id,
        retro_action: retro_action
      });
    };
    (tick = function () {
      return Retro.get({
        id: $stateParams['retro_id']
      }, function (response) {
        $scope.retro = response.retro;
        return $timeout(tick, 50000);
      });
    })();
  }
  return $scope.create = function () {
    var form_data;

    form_data = $scope.retro;
    return Retro.save({
      project_id: $stateParams['project_id'],
      retro: form_data
    }, function (retro) {
      console.log('here');
      return $location.path("/projects/" + $stateParams['project_id'] + "/retros/" + retro._id);
    }, function (response) {
    });
  };
});
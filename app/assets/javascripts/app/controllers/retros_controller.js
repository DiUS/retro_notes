app.controller("RetrosController", function ($scope, $http, $location, $state, $stateParams, $timeout, Page, Project, Retro, RetroResponse, Action) {
  var tick;

  $scope.project = {};
  $scope.retro = {};
  $scope.retros = {};
  if ($state.current.name.indexOf('default.projects.show.retro.new') > -1) {
    Project.get({
      id: $stateParams['project_id']
    }, function (response) {
      $scope.project = response;
    }, function (response) {
      console.log('error');
    });
    Retro.query({
      project_id: $stateParams['project_id']
    }, function (response) {
      $scope.retros = response;
    }, function (response) {
    });
    Page.setTitle('New retro');
  }
  if ($state.current.name.indexOf('default.projects.show.retros.show') > -1) {
    Project.get({
      id: $stateParams['project_id']
    }, function (response) {
      $scope.project = response;
    }, function (response) {
      console.log('error');
    });
    Retro.get({
      id: $stateParams['retro_id']
    }, function (response) {
      $scope.retro = response.retro;
      Page.setTitle($scope.retro.title);
    }, function (response) {
    });
    $scope.resolve_action = function (retro_action) {
      Action.update(retro_action, {
        action_id: retro_action._id,
        retro_action: retro_action
      });
    };
    (tick = function () {
      Retro.get({
        id: $stateParams['retro_id']
      }, function (response) {
        $scope.retro = response.retro;
        $timeout(tick, 50000);
      });
    })();
  }
  $scope.create = function () {
    var form_data = $scope.retro;
    Retro.save({
      project_id: $stateParams['project_id'],
      retro: form_data
    }, function (retro) {
      console.log('here');
      $location.path("/projects/" + $stateParams['project_id'] + "/retros/" + retro._id);
    }, function (response) {
    });
  };
});
app.controller("ProjectsController", function ($scope, $http, $location, $state, $stateParams, Page, Project, ProjectRetro, Retro) {
  $scope.projects = {};
  $scope.project = {};
  if ($state.current.name === 'default.projects') {
    Project.query({}, function (response) {
      $scope.projects = response;
    }, function (response) {
    });
  }
  if ($state.current.name === 'default.projects.show') {
    Project.get({
      id: $stateParams['project_id']
    }, function (response) {
      $scope.project = response;
    }, function (response) {
      $state.transitionTo('default.projects');
    });
    ProjectRetro.query({
      project_id: $stateParams['project_id']
    }, function (response) {
      $scope.retros = response.retros;
    }, function (response) {
    });
    Page.setTitle('Show project');
  }
  $scope.create = function () {
    Project.save({}, {
      project: {
        title: $scope.project.title,
        description: $scope.project.description
      }
    }, function (response) {
      $location.path("/projects");
    }, function (response) {
    });
  };
  if ($state.current.name === 'default.projects.edit') {
    Project.get({
      id: $stateParams['project_id']
    }, function (response) {
      $scope.project = response;
    }, function (response) {
    });
  }
  $scope.update = function () {
    Project.update({
      id: $stateParams['project_id']
    }, {
      project: {
        title: $scope.project.title,
        description: $scope.project.description
      }
    }, function (response) {
      $location.path("/projects");
    }, function (response) {
    });
  };
  $scope.destroy = function (id) {
    Project["delete"]({
      id: id
    }, function (response) {
      var i = 0;
      while (i < $scope.projects.length) {
        if ($scope.projects[i]['id'] === id) {
          $scope.projects.splice(i, 1);
        }
        i++;
      }
    }, function (response) {
    });
  };
});
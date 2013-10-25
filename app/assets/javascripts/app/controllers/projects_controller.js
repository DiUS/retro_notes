app.controller("ProjectsController", function ($scope, $http, $location, $state, $stateParams, Page, Project, ProjectRetro, Retro) {
  $scope.projects = {};
  $scope.project = {};
  if ($state.current.name === 'default.projects') {
    Project.query({}, function (response) {
      return $scope.projects = response;
    }, function (response) {
    });
  }
  if ($state.current.name === 'default.projects.show') {
    Project.get({
      id: $stateParams['project_id']
    }, function (response) {
      return $scope.project = response;
    }, function (response) {
      return $state.transitionTo('default.projects');
    });
    ProjectRetro.query({
      project_id: $stateParams['project_id']
    }, function (response) {
      return $scope.retros = response.retros;
    }, function (response) {
    });
    Page.setTitle('Show project');
  }
  $scope.create = function () {
    return Project.save({}, {
      project: {
        title: $scope.project.title,
        description: $scope.project.description
      }
    }, function (response) {
      return $location.path("/projects");
    }, function (response) {
    });
  };
  if ($state.current.name === 'default.projects.edit') {
    Project.get({
      id: $stateParams['project_id']
    }, function (response) {
      return $scope.project = response;
    }, function (response) {
    });
  }
  $scope.update = function () {
    return Project.update({
      id: $stateParams['project_id']
    }, {
      project: {
        title: $scope.project.title,
        description: $scope.project.description
      }
    }, function (response) {
      return $location.path("/projects");
    }, function (response) {
    });
  };
  return $scope.destroy = function (id) {
    return Project["delete"]({
      id: id
    }, function (response) {
      var i, _results;

      i = 0;
      _results = [];
      while (i < $scope.projects.length) {
        if ($scope.projects[i]['id'] === id) {
          $scope.projects.splice(i, 1);
        }
        _results.push(i++);
      }
      return _results;
    }, function (response) {
    });
  };
});
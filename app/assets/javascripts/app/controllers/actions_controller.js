app.controller("ActionsController", function ($scope, $http, $location, $state, $stateParams, Page, Retro, Action) {
  $scope.new_retro_action = {};
  $scope.create = function (retro_reflection_id) {
    var form_data = $scope.new_retro_action;
    Action.save({
      retro_reflection_id: retro_reflection_id,
      retro_action: form_data
    }, function (action) {
      var actions_length = $scope.retro.actions.length;
      $scope.retro.actions[actions_length] = action;
      $location.path("/projects/" + $stateParams['project_id'] + "/retros/" + $scope.retro._id);
    }, function (action) {
    });
  };
});
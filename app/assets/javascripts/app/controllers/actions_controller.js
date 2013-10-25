(function() {
  app.controller("ActionsController", function($scope, $http, $location, $state, $stateParams, Page, Retro, Action) {
    $scope.new_retro_action = {};
    return $scope.create = function(retro_reflection_id) {
      var form_data;

      form_data = $scope.new_retro_action;
      return Action.save({
        retro_reflection_id: retro_reflection_id,
        retro_action: form_data
      }, function(action) {
        var actions_length;

        actions_length = $scope.retro.actions.length;
        $scope.retro.actions[actions_length] = action;
        return $location.path("/projects/" + $stateParams['project_id'] + "/retros/" + $scope.retro._id);
      }, function(action) {});
    };
  });

}).call(this);

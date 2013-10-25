app.controller("ResponsesController", function ($scope, $http, $location, $state, $stateParams, Page, Retro, RetroResponse) {
  $scope.new_retro_response = {};
  $scope.create = function (retro_reflection_id) {
    var form_data = $scope.new_retro_response;
    RetroResponse.save({
      retro_reflection_id: retro_reflection_id,
      retro_response: form_data
    }, function (retro_response) {
      var i = 0;
      $scope.new_retro_response = {};
      while (i < $scope.retro.retro_reflections.length) {
        if ($scope.retro.retro_reflections[i]._id === retro_response.retro_reflection_id) {
          $scope.retro.retro_reflections[i].retro_responses.push(retro_response);
          break;
        }
        i++;
      }
      $location.path("/projects/" + $stateParams['project_id'] + "/retros/" + $scope.retro._id);
    }, function (response) {
    });
  };
});
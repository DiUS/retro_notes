app.controller("ResponsesController", function ($scope, $http, $location, $state, $stateParams, Page, Retro, RetroResponse) {
  $scope.new_retro_response = {};
  return $scope.create = function (retro_reflection_id) {
    var form_data;

    form_data = $scope.new_retro_response;
    return RetroResponse.save({
      retro_reflection_id: retro_reflection_id,
      retro_response: form_data
    }, function (response) {
      var i, retro_response;

      $scope.new_retro_response = {};
      i = 0;
      retro_response = response;
      while (i < $scope.retro.retro_reflections.length) {
        if ($scope.retro.retro_reflections[i]._id === retro_response.retro_reflection_id) {
          $scope.retro.retro_reflections[i].retro_responses.push(retro_response);
          break;
        }
        i++;
      }
      return $location.path("/projects/" + $stateParams['project_id'] + "/retros/" + $scope.retro._id);
    }, function (response) {
    });
  };
});
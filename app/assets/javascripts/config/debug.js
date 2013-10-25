app.run(function ($rootScope, $state, $stateParams) {
  $rootScope.$debugMode = "on";
  $rootScope.$state = $state;
  return $rootScope.$stateParams = $stateParams;
});
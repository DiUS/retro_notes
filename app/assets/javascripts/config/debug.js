app.run(function ($rootScope, $state, $stateParams) {
  $rootScope.$debugMode = "on";
  $rootScope.$state = $state;
  $rootScope.$stateParams = $stateParams;
});
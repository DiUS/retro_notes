(function() {
  app.config(function($httpProvider) {
    var authToken;

    authToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
    return $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken;
  });

}).call(this);

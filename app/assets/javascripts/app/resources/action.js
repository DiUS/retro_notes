(function() {
  app.factory("Action", function($resource, API_PREFIX) {
    return $resource(API_PREFIX + "/actions/:action_id", {
      action_id: "@action_id"
    }, {
      query: {
        method: 'GET',
        isArray: false
      },
      update: {
        method: "PUT"
      }
    });
  });

}).call(this);

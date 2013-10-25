(function() {
  app.factory("RetroResponse", function($resource, API_PREFIX) {
    return $resource(API_PREFIX + "/retro_responses/:retro_response_id", {
      retro_response_id: "@retro_response_id"
    }, {
      query: {
        method: 'GET',
        isArray: false
      }
    });
  });

}).call(this);

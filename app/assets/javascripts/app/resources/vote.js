(function() {
  app.factory("Vote", function($resource, API_PREFIX) {
    return $resource(API_PREFIX + "retro_responses/:id/votes/:vote_id", {
      id: "@id"
    }, {
      update: {
        method: "PUT"
      }
    });
  });

}).call(this);

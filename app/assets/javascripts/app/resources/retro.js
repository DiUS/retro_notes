(function() {
  app.factory("Retro", function($resource, API_PREFIX) {
    return $resource(API_PREFIX + "/retros/:id", {
      id: "@_id"
    }, {
      update: {
        method: "PUT"
      }
    });
  });

  app.factory("RetroService", function($rootScope, RetroSession) {
    return {
      retro: {},
      get: function(retro_id) {
        var self;

        self = this;
        return Retro.get({
          id: retro_id
        }, function(response) {
          return self.retro = response.retro;
        });
      }
    };
  });

}).call(this);

app.factory("Project", function ($resource, API_PREFIX) {
  return $resource(API_PREFIX + "/projects/:id", {
    id: "@id"
  }, {
    update: {
      method: "PUT"
    }
  });
});
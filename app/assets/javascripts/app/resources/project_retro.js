app.factory("ProjectRetro", function ($resource, API_PREFIX) {
  return $resource(API_PREFIX + "/projects/:project_id/retros/:retro_id", {
    project_id: "@project_id",
    retro_id: "@retro_id"
  }, {
    query: {
      method: 'GET',
      isArray: false
    }
  });
});
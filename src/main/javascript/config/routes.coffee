# Configure 'app' routing. The $stateProvider and $urlRouterProvider
# will be automatically injected into the configurator.

app.config ['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider) ->

  # Make sure that any other request beside one that is already defined
  # in stateProvider will be redirected to root.
  $urlRouterProvider
    .otherwise("/")

  # Define 'app' states
  $stateProvider
    .state "default",
      abstract: true
      views:
        "":
          controller: "ApplicationController"
          templateUrl: "/static/layouts/default.html"
        "form":
          template: "Hello test"

    # Projects
    .state "default.projects",
      url: "/projects"
      views:
        "":
          controller: "ProjectsController"
          templateUrl: "/static/projects/index.html"

    .state "default.projects.new",
      url: "/new"
      views:
        "@default":
          controller: "ProjectsController"
          templateUrl: "/static/projects/new.html"

    .state "default.projects.show",
      url: "/:project_id"
      views:
        "@default":
          controller: "ProjectsController"
          templateUrl: "/static/projects/show.html"

    # TBA
    # .state "default.projects.edit",
    #   url: "/:project_id/edit"
    #   views:
    #     "@default":
    #       controller: "ProjectsController"
    #       templateUrl: "/static/projects/edit.html"


    # Project Retro Sessions
    .state "default.projects.show.retros", 
      url: "/retros",
      abstract: true

    .state "default.projects.show.retros.new",
      url: "/new"
      views:
        "@default":
          controller: "RetrosController"
          templateUrl: "/static/retros/new.html"

    # .state "default.projects.show.retros.show",
    #   url: "/:feedback_session_id"
    #   views:
    #     "@default":
    #       controller: "RetroController"
    #       templateUrl: "/static/retros/show.html"

    .state "default.projects.show.retros.show",
      url: "/:retro_id"
      views:
        "@default":
          controller: "RetrosController"
          templateUrl: "/static/retros/show.html"

    .state "default.projects.show.retros.show.response",
      url: '/response'
      abstract: true
    .state "default.projects.show.retros.show.response.new",
      url: "/new"
      views:
        "response_form@default.projects.show.retros.show":
          templateUrl: "/static/retros/new_response_form.html"
          controller: "ResponsesController"
    .state "default.projects.show.retros.show.action",
      url: '/action'
      abstract: true
    .state "default.projects.show.retros.show.action.new",
      url: "/new"
      views:
        "action_form@default.projects.show.retros.show":
          templateUrl: "/static/retros/new_action_form.html"
          controller: "ActionsController"

]
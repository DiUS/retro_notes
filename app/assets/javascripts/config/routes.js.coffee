# Configure 'app' routing. The $stateProvider and $urlRouterProvider
# will be automatically injected into the configurator.

app.config ($stateProvider, $urlRouterProvider) ->

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
          templateUrl: "/assets/layouts/default.html"
        "form":
          template: "Hello test"

    # Projects
    .state "default.projects",
      url: "/projects"
      views:
        "":
          controller: "ProjectsController"
          templateUrl: "/assets/projects/index.html"

    .state "default.projects.new",
      url: "/new"
      views:
        "@default":
          controller: "ProjectsController"
          templateUrl: "/assets/projects/new.html"

    .state "default.projects.show",
      url: "/:project_id"
      views:
        "@default":
          controller: "ProjectsController"
          templateUrl: "/assets/projects/show.html"

    # TBA
    # .state "default.projects.edit",
    #   url: "/:project_id/edit"
    #   views:
    #     "@default":
    #       controller: "ProjectsController"
    #       templateUrl: "/assets/projects/edit.html"


    # Project Feedback Sessions
    .state "default.projects.show.feedback_sessions", 
      url: "/feedback_sessions",
      abstract: true

    .state "default.projects.show.feedback_sessions.new",
      url: "/new"
      views:
        "@default":
          controller: "ProjectFeedbackSessionsController"
          templateUrl: "/assets/feedback_sessions/new.html"

    # .state "default.projects.show.feedback_sessions.show",
    #   url: "/:feedback_session_id"
    #   views:
    #     "@default":
    #       controller: "ProjectFeedbackSessionsController"
    #       templateUrl: "/assets/feedback_sessions/show.html"

    .state "default.projects.show.feedback_sessions.show",
      url: "/:feedback_session_id"
      views:
        "@default":
          controller: "ProjectFeedbackSessionsController"
          templateUrl: "/assets/feedback_sessions/show.html"
        # "form@default.projects.show.feedback_sessions.show":
        #   templateUrl: "/assets/feedback_sessions/_new_response_form.html"

    .state "default.projects.show.feedback_sessions.show.response",
      url: '/response'
      abstract: true
    .state "default.projects.show.feedback_sessions.show.response.new",
      url: "/new"
      views:
        # "@default":
        #   controller: "ProjectFeedbackSessionsController"
        #   templateUrl: "/assets/feedback_sessions/show.html"
        "form@default.projects.show.feedback_sessions.show":
          templateUrl: "/assets/feedback_sessions/_new_response_form.html"
          controller: "ResponsesController"



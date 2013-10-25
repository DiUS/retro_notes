app.config(function ($stateProvider, $urlRouterProvider) {
  $urlRouterProvider.otherwise("/");
  return $stateProvider.state("default", {
    abstract: true,
    views: {
      "": {
        controller: "ApplicationController",
        templateUrl: "/assets/layouts/default.html"
      },
      "form": {
        template: "Hello test"
      }
    }
  }).state("default.projects", {
      url: "/projects",
      views: {
        "": {
          controller: "ProjectsController",
          templateUrl: "/assets/projects/index.html"
        }
      }
    }).state("default.projects.new", {
      url: "/new",
      views: {
        "@default": {
          controller: "ProjectsController",
          templateUrl: "/assets/projects/new.html"
        }
      }
    }).state("default.projects.show", {
      url: "/:project_id",
      views: {
        "@default": {
          controller: "ProjectsController",
          templateUrl: "/assets/projects/show.html"
        }
      }
    }).state("default.projects.show.retros", {
      url: "/retros",
      abstract: true
    }).state("default.projects.show.retros.new", {
      url: "/new",
      views: {
        "@default": {
          controller: "RetrosController",
          templateUrl: "/assets/retros/new.html"
        }
      }
    }).state("default.projects.show.retros.show", {
      url: "/:retro_id",
      views: {
        "@default": {
          controller: "RetrosController",
          templateUrl: "/assets/retros/show.html"
        }
      }
    }).state("default.projects.show.retros.show.response", {
      url: '/response',
      abstract: true
    }).state("default.projects.show.retros.show.response.new", {
      url: "/new",
      views: {
        "response_form@default.projects.show.retros.show": {
          templateUrl: "/assets/retros/_new_response_form.html",
          controller: "ResponsesController"
        }
      }
    }).state("default.projects.show.retros.show.action", {
      url: '/action',
      abstract: true
    }).state("default.projects.show.retros.show.action.new", {
      url: "/new",
      views: {
        "action_form@default.projects.show.retros.show": {
          templateUrl: "/assets/retros/_new_action_form.html",
          controller: "ActionsController"
        }
      }
    });
});
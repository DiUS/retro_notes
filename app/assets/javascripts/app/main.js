var app = angular.module("app", ["ngResource", "ui.compat"]).value('$anchorScroll', angular.noop);

app.factory('Page', function () {
  var appended, title;

  title = 'iRetro';
  appended = ' | iRetro';
  return {
    title: function () {
      return title;
    },
    setTitle: function (newTitle) {
      document.title = newTitle + appended;
      return title = newTitle + appended;
    }
  };
});
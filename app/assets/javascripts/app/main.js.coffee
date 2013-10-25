# Create 'app' angular application (module)
@app = angular.module("app", [
  # ngResource
  "ngResource",

  # ui-router
  "ui.compat"
]).value('$anchorScroll', angular.noop)


app.factory 'Page', ->
  title = 'iRetro'
  appended = ' | iRetro'
  title: -> title
  setTitle: (newTitle) ->
    document.title =  newTitle + appended
    title =  newTitle + appended
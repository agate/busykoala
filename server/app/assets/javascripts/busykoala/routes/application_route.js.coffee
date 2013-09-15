Busykoala.IndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo 'nodes'

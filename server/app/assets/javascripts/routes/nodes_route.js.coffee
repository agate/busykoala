Busykoala.NodesRoute = Ember.Route.extend
  model: ->
    Busykoala.Node.loadAll()

Busykoala.NodesIndexRoute = Ember.Route.extend

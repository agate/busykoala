Busykoala.ApplicationRoute = Ember.Route.extend
  setupController: (controller)->
    loopGetNodes = ->
      Busykoala.Node.loadAll().then (response)->
        # console.log response
        controller.set('nodes', response)
        setTimeout(loopGetNodes, 5000)
    loopGetNodes()

Busykoala.IndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo 'nodes'

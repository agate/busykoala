Busykoala.NodeRoute = Ember.Route.extend
  setupController: (controller)->
    loopGetNodes = ->
      Busykoala.Node.loadAll().then (response)->
        # console.log response
        controller.set('nodes', response)
        setTimeout(loopGetNodes, 5000)
    loopGetNodes()

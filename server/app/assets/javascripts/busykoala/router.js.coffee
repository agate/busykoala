Busykoala.Router.map ->
  @resource 'nodes', ->
    @resource 'node', { path: '/:node_id' }, ->
      @route 'connect'

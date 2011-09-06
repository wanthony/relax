RelaxClient = require './relax.client'

exports.client = (opts) ->
  new RelaxClient(opts)

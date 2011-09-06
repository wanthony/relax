vows = require 'vows'
assert = require 'assert'

relax = require('../lib/relax')

uri = 'https://username:password@localhost:5984/'

vows.describe('RelaxClient').addBatch(

  'Initializing a new RelaxClient with a uri string':
    topic: ->
      client = relax.client(uri: uri)
      return client.uri

    "The URI should be https://username:password@localhost:5984": (topic) ->
      assert.equal uri, topic.href

  "Initializing a new RelaxClient with URI parameters":
    topic: ->
      client = relax.client(
        host: 'localhost'
        port: 5984
        username: 'username'
        password: 'password'
        protocol: 'https'
      )

      client.uri

    "The URI should be https://username:password@localhost:5984": (topic) ->
      assert.equal topic.href, uri

  "Initializing a new RelaxClient with a string parameter":
    topic: ->
      client = relax.client('https://username:password@localhost:5984/')
      client.uri

    "The URI should be https://username:password@localhost:5984": (topic) ->
      assert.equal topic.href, uri

  "Getting or creating a database":
    topic: ->
      relax.client('http://username:password@localhost:5984')

    "I should be able to set the active database to an existing database": (client) ->
      client.setDatabase('existing')
      assert.equal client.database, 'existing'

    "I should be able to create a new database": (client) ->
      client.createDatabase('my_test_db', (res, obj) ->
        assert.equal(res.body, '{"ok": true}')
        assert.equal(obj.ok, true)
      )

).run()

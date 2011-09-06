http = require 'http'
https = require 'https'
url = require 'url'

class RelaxClient
  # Initialize a new RelaxClient object.
  #
  # Connect to the couchdb server and authenticate.
  #
  # @param opts an object with the following properties:
  #   {
  #     uri: 'https://username:password@hostname:port', # Full URI.  If supplied, only this is used.
  #     protocol: 'http' || 'https', # Defaults to 'http'
  #     username: 'username', # The CouchDB username
  #     password: 'password', # The CouchDB password
  #     host: 'localhost', # The CouchDB host
  #     port: 5984 # The CouchDB port
  #   }
  #
  # `opts` can also be a string, which is the same as specifying opts.uri
  constructor: (opts = {}) ->
    @uri = opts.uri || ''

    if typeof opts == "string"
      @uri = opts

    if @uri == ''
      @uri = "#{opts.protocol}://"
      @uri += "#{opts.username}:#{opts.password}@" if opts.username and opts.password
      @uri += "#{opts.host}:#{opts.port || 5984}"

    @uri = url.parse(@uri)
    @http = if @uri.protocol == 'http:' then http else https

  # Return the internal URI object.
  #
  # This is the result of url.parse on the URI we are initialized with.
  uri: ->
    @uri

  # Sets the database that we will be acting on
  setDatabase: (db) -> 
    @database = db

  # Create a new database
  createDatabase: (db, cb) ->
    opts =
      host: @uri.host
      port: @uri.port
      path: "/#{db}"
      method: 'POST'

    # make the request to create a new DB (a POST request).
    #
    # The callback is called with the HTTP response.  We parse the body
    # of the response and send that back to the user, along with the unparsed body.
    @http.request(opts, (res) ->
      cb(res, JSON.parse(res.body))
    )

exports = module.exports = RelaxClient

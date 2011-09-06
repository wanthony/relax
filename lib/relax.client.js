(function() {
  var RelaxClient, exports, http, https, url;
  http = require('http');
  https = require('https');
  url = require('url');
  RelaxClient = (function() {
    function RelaxClient(opts) {
      if (opts == null) {
        opts = {};
      }
      this.uri = opts.uri || '';
      if (typeof opts === "string") {
        this.uri = opts;
      }
      if (this.uri === '') {
        this.uri = "" + opts.protocol + "://";
        if (opts.username && opts.password) {
          this.uri += "" + opts.username + ":" + opts.password + "@";
        }
        this.uri += "" + opts.host + ":" + (opts.port || 5984);
      }
      this.uri = url.parse(this.uri);
      this.http = this.uri.protocol === 'http:' ? http : https;
    }
    RelaxClient.prototype.uri = function() {
      return this.uri;
    };
    RelaxClient.prototype.setDatabase = function(db) {
      return this.database = db;
    };
    RelaxClient.prototype.createDatabase = function(db, cb) {
      var opts;
      opts = {
        host: this.uri.host,
        port: this.uri.port,
        path: "/" + db,
        method: 'POST'
      };
      return this.http.request(opts, function(res) {
        return cb(res, JSON.parse(res.body));
      });
    };
    return RelaxClient;
  })();
  exports = module.exports = RelaxClient;
}).call(this);

(function() {
  var RelaxClient;
  RelaxClient = require('./relax.client');
  exports.client = function(opts) {
    return new RelaxClient(opts);
  };
}).call(this);

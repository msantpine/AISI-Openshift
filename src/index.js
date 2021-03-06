var express = require('express'),
    http = require('http'),
    redis = require('redis');

var app = express();
var client = redis.createClient('6379', process.env.REDIS_ADDR);

app.get('/', function(req, res, next) {
  client.incr('counter', function(err, counter) {
    if(err) return next(err);
    res.send('This page has been viewed ' + counter + ' times!');
  });
});

// Path used by the readiness and liveness probes
app.get('/heartbeat', function(req, res, next) {
  res.send("I'm alive!");
});

http.createServer(app).listen(process.env.PORT || 8080, function() {
  console.log('Listening on port ' + (process.env.PORT || 8080));
});
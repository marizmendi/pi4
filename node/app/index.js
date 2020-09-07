var http = require('http');

var server = http.createServer(function (request, response) {
  response.writeHead(200, {"Content-Type": "text/plain"});
  message = request.headers["x-forwarded-for"]
  response.end(message);
});

server.listen(8000);

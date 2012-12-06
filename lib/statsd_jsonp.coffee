fs     = require 'fs'
http   = require 'http'
url    = require 'url'
statsd = require 'node-statsd'

configFile = if process.argv[2]?
  process.argv[2]
else
  "#{__dirname}/../config.json"

config   = JSON.parse fs.readFileSync configFile
reporter = new statsd.StatsD config.statsdHost, config.statsdPort

server = http.createServer (req, res) ->
  params     = url.parse(req.url, true).query
  callback   = if params.callback? then params.callback else 'callback'
  method     = params.method
  stat       = params.stat
  value      = params.value
  samplerate = params.samplerate

  unless method?
    res.writeHead 400, 'Content-Type': 'application/javascript'
    res.end "#{callback}({ \"error\": \"Method was not provided.\" })"

    return

  unless stat?
    res.writeHead 400, 'Content-Type': 'application/javascript'
    res.end "#{callback}({ \"error\": \"Stat was not provided.\" })"

    return

  unless value?
    res.writeHead 400, 'Content-Type': 'application/javascript'
    res.end "#{callback}({ \"error\": \"Value was not provided.\" })"

    return

  if samplerate?
    reporter[method] stat, value, samplerate

    console.log "reporting #{method} #{stat} #{value} #{samplerate}"
  else
    reporter[method] stat, value

    console.log "reporting #{method} #{stat} #{value}"

  res.writeHead 200, 'Content-Type': 'application/javascript'
  res.end "#{callback}({})"

server.listen config.port


connect = require 'connect'

app = connect().
  use(connect.static 'public').
  listen 8123


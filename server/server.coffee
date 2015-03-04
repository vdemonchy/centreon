#
# dependencies
#
express = require 'express'
path = require "path"
favicon = require 'serve-favicon'
logger = require 'morgan'
methodOverride = require 'method-override'
session = require 'express-session'
bodyParser = require 'body-parser'
multer = require 'multer'
errorHandler = require 'errorhandler'
livereload = require 'connect-livereload'

#
# app configuration
#
appDirName = "web"
app = express()

app.set 'port', 9002
switch app.get('env')
    when 'dev'
        app.use logger app.get('env')
    else
        app.use logger 'tiny'
app.use methodOverride()
app.use bodyParser.json()
app.use bodyParser.urlencoded({ extended: true })
app.use multer()
app.use express.static(path.join(__dirname, "..", appDirName))
app.use errorHandler()

allowCrossDomain = (req, res, next) ->
    res.header "Access-Control-Allow-Origin", "*"
    res.header "Access-Control-Allow-Headers", "X-Requested-With"
    next()

app.use livereload(
    port: 35729
    excludeList: [
        ".woff"
        ".flv"
    ]
)
app.use allowCrossDomain

#
# routes
#
app.get '/mocks/building/*.json', (req, res) ->
    res.sendfile 'web/mocks/building/0.json'

app.get '/mocks/room/*.json', (req, res) ->
    res.sendfile 'web/mocks/room/0.json'

app.get '/mocks/rack/*.json', (req, res) ->
    res.sendfile 'web/mocks/rack/0.json'

app.get '/mocks/device/*.json', (req, res) ->
    res.sendfile 'web/mocks/device/0.json'

app.get '/docs/*', (req, res, next) ->
    if !req.xhr
        res.sendfile 'web/docs/index.html'

# ?
app.post '/post/mocks/prefs.json', (req, res) ->
    res.sendfile 'web/mocks/prefs.json'

app.post '/post/mocks/stats2.json', (req, res) ->
    res.sendfile 'web/mocks/stats2.json'

app.post '/post/*/*.json', (req, res) ->
    localname = __dirname.replace 'server', ''
    filename = req._parsedUrl.pathname.replace('/post', localname + appDirName)
    res.sendfile filename

# upload
app.post '/upload/', (req, res) ->
    setTimeout(->
        res.sendfile 'web/mocks/import/real.json'
    , 5000)

# update
app.post '/post/*/*/', (req, res) ->
    res.sendfile 'web/' + req.params[0] + '/' + req.params[1] + '/0.json'

#creation
app.put '/put/*/*/', (req, res) ->
    res.sendfile 'web/' + req.params[0] + '/' + req.params[1] + '/0.json'

app.get '*', (req, res, next)->
    if !req.xhr
        res.sendfile 'web/index.html'

app.listen app.get("port"), ->
    console.log(
        'Express server listening on port[' +
        app.get('port') +
        '] in environment[' +
        app.get('env') +
        ']'
    )

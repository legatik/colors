
###
 * Module dependencies.
###
express = require 'express'
http = require 'http'
path = require 'path'
mongoose = require 'mongoose'
config = require './conf/config'
require 'express-namespace'
assets = require 'connect-assets'
db = require './lib/db'
auth = require './lib/auth'
passport = require 'passport'

RedisStore = require('connect-redis')(express)
app = express()

{User, Product, Face, Brend} = db.models

#console.log "Brend.createThis",Brend.createThis
#Brend.createThis (brend) ->
#  Face.createThis (face) ->
#    Product.createThis brend, face, (Product) ->
#      console.log 'merch', Product

app.configure () ->
	app.set "port", process.env.PORT or 3000
	app.set "views", __dirname + "/views"
	app.set 'view engine', 'jade'
	app.use express.favicon()
	app.use express.logger 'dev'
	app.use express.bodyParser()
	app.use express.cookieParser()
	app.use express.methodOverride()
	app.use express.session
		secret: "tobeornottobethatisthequestion",
		cookie: { maxAge: 3600000 * 24 * 365, httpOnly: false }
		store: new RedisStore()
	app.use express.static path.join __dirname, 'public'
	app.use assets {src: path.join __dirname, 'public'}
	app.use passport.initialize()
	app.use passport.session()

app.configure 'development', () ->
	app.use express.errorHandler()

db.connection.connect(config.db)

auth.init app, passport

options = {db:{type: 'mongo'}}

app.namespace '', require('./controllers/home').boot.bind @, app
app.namespace '/tool', require('./controllers/tool').boot.bind @, app
app.namespace '/header', require('./controllers/header').boot.bind @, app
app.namespace '/nav', require('./controllers/nav').boot.bind @, app
app.namespace '/create', require('./controllers/create').boot.bind @, app
app.namespace '/search', require('./controllers/search').boot.bind @, app
app.namespace '/edit', require('./controllers/edit').boot.bind @, app
app.namespace '/user', require('./controllers/user').boot.bind @, app
app.namespace '/product', require('./controllers/product').boot.bind @, app

app.get '/register', (req, res) ->
	res.render 'registration', {title: 'Onlile JS Compiller'}

#app.post '/register', (req, res) ->
#	user = req.body
#	User.register user, (err,user) ->
#		if err
#			res.send {status:false, data:err}
#		else
#			res.send {status:true, data:user}

#app.get '/login', (req, res) ->
#	res.render 'login', {title: 'login'}

#app.post "/login", (req, res, next) ->
#	passport.authenticate("local", (err, user, info) ->
#		if user
#			req.logIn user, (err) ->
#				res.send true
#		else
#			res.send false
#	) req, res, next


app.get '/logout', (req,res) ->
	req.logout()
	res.redirect '/'


http.createServer(app).listen app.get('port'), () ->
	console.log "Express server listening on port " + app.get('port')


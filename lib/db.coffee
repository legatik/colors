mongoose = require 'mongoose'
User = require './models/user'
Product = require './models/merchandise'
Face = require './models/face'
Brend = require './models/brend'
Body = require './models/body'
New = require './models/new'
Action = require './models/action'

module.exports =
	models: {User, Product, Face, Brend, Body, New, Action}
	connection:
		connect: (path) ->
			db = mongoose.connect path
		disconnect: () ->
		Types: mongoose.Types

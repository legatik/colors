mongoose = require 'mongoose'
User = require './models/user'
Product = require './models/merchandise'
Face = require './models/face'
Brend = require './models/brend'
Body = require './models/body'

module.exports =
	models: {User, Product, Face, Brend, Body}
	connection:
		connect: (path) ->
			db = mongoose.connect path
		disconnect: () ->
		Types: mongoose.Types

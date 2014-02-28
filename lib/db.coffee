mongoose = require 'mongoose'
User = require './models/user'
Product = require './models/product'
Dish = require './models/dish'
Comment = require './models/comment'
Raiting  = require './models/raiting' 

module.exports =
	models: {User, Product, Dish, Comment, Raiting}
	connection:
		connect: (path) ->
			db = mongoose.connect path
		disconnect: () ->
		Types: mongoose.Types

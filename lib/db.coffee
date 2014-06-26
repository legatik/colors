mongoose = require 'mongoose'
User = require './models/user'
Product = require './models/merchandise'
Face = require './models/face'
Brend = require './models/brend'
Body = require './models/body'
New = require './models/new'
Action = require './models/action'
Makeup = require './models/makeup'
Forman = require './models/forman'
Set = require './models/set'
Access = require './models/access'
PComment = require './models/pComment'
Comment = require './models/comment'
Cart = require './models/cart'
Voucher = require './models/voucher'
Hair = require './models/hair'

module.exports =
	models: {User, Product, Face, Brend, Body, New, Action, Makeup, Forman, Set, Access, PComment, Comment, Cart, Voucher, Hair}
	connection:
		connect: (path) ->
			db = mongoose.connect path
		disconnect: () ->
		Types: mongoose.Types

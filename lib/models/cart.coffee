mongoose = require 'mongoose'
_ = require 'underscore'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

cart = new Schema(
	user          : {type: ObjectId, ref: 'User'}
	products      : [{type: ObjectId, ref: 'Product'}]
)
Model = mongoose.model 'Cart', cart

module.exports = Model

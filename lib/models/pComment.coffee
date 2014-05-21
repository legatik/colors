mongoose = require 'mongoose'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

pComment = new Schema
  comments : Array
  name     : String
  date     : Date
  text     : String
  yes      : Number
  no       : Number
  product  : {type: ObjectId, ref: 'Product'}
  user     : {type: ObjectId, ref: 'User'}
  
Model = mongoose.model 'PComment', pComment


module.exports = Model

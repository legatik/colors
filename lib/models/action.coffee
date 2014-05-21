mongoose = require 'mongoose'
db = require '../db'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

action = new Schema
  title       : String
  description : String
  active      : Boolean
  img         : String
  logo        : String
  poster      : String
  products    : [{type: ObjectId, ref: 'Product'}]
  
Model = mongoose.model 'Action', action



module.exports = Model

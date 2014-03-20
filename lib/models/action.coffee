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
  products    : Array
  
Model = mongoose.model 'Action', action



module.exports = Model

mongoose = require 'mongoose'
db = require '../db'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

comment = new Schema
  name      : String
  text      : String
  date      : Date
  
Model = mongoose.model 'Comment', comment




module.exports = Model

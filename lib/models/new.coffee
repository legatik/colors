mongoose = require 'mongoose'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

news = new Schema
  title           : String
  logo            : String
  vetrina         : Boolean
  images          : Array
  descriptions    : Array 
  
Model = mongoose.model 'New', news


module.exports = Model

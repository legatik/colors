mongoose = require 'mongoose'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

hair = new Schema
  type            : String
  podType         : String
  
Model = mongoose.model 'Hair', hair


module.exports = Model

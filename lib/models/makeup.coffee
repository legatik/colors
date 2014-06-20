mongoose = require 'mongoose'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

makeup = new Schema
  type            : String
  podType         : String
  
Model = mongoose.model 'Makeup', makeup



module.exports = Model

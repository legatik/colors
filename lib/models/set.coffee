mongoose = require 'mongoose'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

set = new Schema
  type            : String
  podType         : String
  
Model = mongoose.model 'Set', set



module.exports = Model

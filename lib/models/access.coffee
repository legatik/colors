mongoose = require 'mongoose'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

access = new Schema
  type            : String
  podType         : String
  
Model = mongoose.model 'Access', access



module.exports = Model

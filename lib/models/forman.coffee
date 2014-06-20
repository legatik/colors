mongoose = require 'mongoose'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

forman = new Schema
  type            : String
  podType         : String
  kozha           : Array
  
Model = mongoose.model 'Forman', forman


module.exports = Model

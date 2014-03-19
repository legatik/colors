mongoose = require 'mongoose'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

face = new Schema
  type            : String
  podType         : String
  kozha           : Array
  nesovershenstva : Array 
  
Model = mongoose.model 'Face', face

Model.createThis = (cb) ->
  testObj = 
    ottenok         : "Обычный"
    type            : "Фалический"
    kozha           : "Растягивающаяся"
    nesovershenstva : "Совершенин"
  @create testObj, (err, face) ->
    cb(face)


module.exports = Model

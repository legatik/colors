mongoose = require 'mongoose'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

face = new Schema
  type            : String
  podType         : String
  kozha           : String
  nesovershenstva : String 
  
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

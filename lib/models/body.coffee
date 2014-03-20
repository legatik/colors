mongoose = require 'mongoose'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

body = new Schema
  type            : String
  podType         : String
  nesovershenstva : Array 
  
Model = mongoose.model 'Body', body

Model.createThis = (cb) ->
  testObj = 
    ottenok         : "Обычный"
    type            : "Фалический"
    kozha           : "Растягивающаяся"
    nesovershenstva : "Совершенин"
  @create testObj, (err, face) ->
    cb(face)


module.exports = Model

mongoose = require 'mongoose'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

news = new Schema
  logo            : String
  vetrina         : Boolean
  images          : String
  descriptions    : Array 
  
Model = mongoose.model 'New', news

Model.createThis = (cb) ->
  testObj = 
    ottenok         : "Обычный"
    type            : "Фалический"
    kozha           : "Растягивающаяся"
    nesovershenstva : "Совершенин"
  @create testObj, (err, face) ->
    cb(face)


module.exports = Model

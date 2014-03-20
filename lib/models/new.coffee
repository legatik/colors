mongoose = require 'mongoose'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

news = new Schema
  logoImg         : String
  vetrina         : Boolean
  imgArr          : String
  descArr         : Array 
  
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

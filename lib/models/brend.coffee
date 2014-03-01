mongoose = require 'mongoose'
db = require '../db'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

brend = new Schema
  title : String
  
Model = mongoose.model 'Brend', brend


Model.createThis = (cb) ->
  testObj = 
    title : "Дары природы"
  @create testObj, (err, brend) ->
    cb(brend)

module.exports = Model

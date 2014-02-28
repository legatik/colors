mongoose = require 'mongoose'
db = require '../db'
Dish = require './dish'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

comment = new Schema
  idUser: [{type: ObjectId, ref: 'User'}]
  message: String
  dateAdded: Date
  
Model = mongoose.model 'Comment', comment


Model.createThis = (idUser, idDish, message, cb) ->
  date = new Date
  @create {message:message, idUser:idUser, dateAdded:date}, (err, comment) ->
    if err
      cb && cb(err)
    else
      commentId = comment._id
      Dish.findOne {_id : idDish} , (err, dish) ->
        dish.comments.push commentId
        dish.save ->
          cb(null)
        



module.exports = Model

mongoose = require 'mongoose'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

raiting = new Schema
	st   : Boolean
	dish : {type: ObjectId, ref: 'Dish'} 
Model = mongoose.model 'Raiting', raiting

Model.createThis = (st,  dishId, cb) ->
  @create {st:st, dish:dishId}, (err, raiting) ->
    cb(raiting)


module.exports = Model

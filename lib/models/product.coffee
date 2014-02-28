mongoose = require 'mongoose'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

product = new Schema
  title: String
  species: String
  necessarily:Boolean
  id:String
  
Model = mongoose.model 'Product', product

Model.createThis = () ->
  @create {title: 'пупок23'}, () ->
    console.log('Create', arguments)

module.exports = Model

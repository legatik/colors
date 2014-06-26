mongoose = require 'mongoose'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

product = new Schema
  title            : String
  minOpisanie      : String
  obem             : Number
  ves              : Number
  id               : Number
  oldCost          : Number
  cost             : Number
  picture          : Array
  opisanie         : String
  primenenie       : String
  vetrina          : Boolean
  ostatok          : Number
  vid              : Array
  imgVid           : String
  popular          : Number
  balls            : String
  isFace           : {type: ObjectId, ref: 'Face'}
  isBody           : {type: ObjectId, ref: 'Body'}
  isMakeup         : {type: ObjectId, ref: 'Makeup'}
  isSet            : {type: ObjectId, ref: 'Set'}
  isHair            : {type: ObjectId, ref: 'Hair'}
  isAccess         : {type: ObjectId, ref: 'Access'}
  isForman         : {type: ObjectId, ref: 'Forman'}
  brend            : {type: ObjectId, ref: 'Brend'}
  dateAdding : Date


Model = mongoose.model 'Product', product


module.exports = Model


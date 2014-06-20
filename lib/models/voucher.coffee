mongoose = require 'mongoose'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

voucher = new Schema
  name   : String
  code   : String
  ps     : Number
  active : Boolean
  
Model = mongoose.model 'Voucher', voucher



module.exports = Model

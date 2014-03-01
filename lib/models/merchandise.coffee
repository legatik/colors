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
  isFace           : {type: ObjectId, ref: 'Face'}
  brend            : {type: ObjectId, ref: 'Brend'}
  
Model = mongoose.model 'Product', product

Model.createThis = (brend, face, cb) ->
  testObj = 
    title            : "Хуй"
    minOpisanie      : "Он охуенен"
    obem             : 18
    ves              : 200
    id               : 777
    oldCost          : 1
    cost             : 100
    picture          : ["/img/merchandise/test.jpg"]
    opisanie         : "Нужен каждой бабе"
    primenenie       : "Принимается Внутрее"
    isFace           : face["_id"]
    brend            : brend["_id"]
  @create testObj, (err, product) ->
    cb(product)
    
module.exports = Model

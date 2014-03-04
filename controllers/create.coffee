db = require '../lib/db'
_ = require 'underscore'
nodemailer = require 'nodemailer'

{User, Product, Face, Brend} = db.models

exports.boot = (app) ->

  app.post '/face', (req, res) ->
    body = req.body
    newFace = new Face(body.type)
    newProd = Product(body.product)
    
    newFace.save (err, face) ->
      newProd.isFace = face["_id"]
      newProd.save () ->
        res.send 200

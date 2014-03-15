db = require '../lib/db'
_ = require 'underscore'
nodemailer = require 'nodemailer'
fs = require "fs-extra"

{User, Product, Face, Brend} = db.models

exports.boot = (app) ->

  app.post '/face', (req, res) ->
    body = JSON.parse req.body.data
    newFace = new Face(body.type)
    newProd = Product(body.product)
    newFace.save (err, face) ->
      newProd.isFace = face["_id"]
      newProd.save (err, product) ->
        res.send 200
        _.each req.files, (data,key)->
            type = data.mime.replace("image/", "")
            path = './public/img/products/' + product["_id"]
            if key == "vid"
                product.imgVid = type
            else
                product.picture.push(type)
            fs.mkdir path, (err) ->
              fs.copy data.path, path + "/" + key + "." + type, (err) ->
        product.save()

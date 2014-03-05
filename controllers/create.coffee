db = require '../lib/db'
_ = require 'underscore'
nodemailer = require 'nodemailer'
fs = require "fs-extra"

{User, Product, Face, Brend} = db.models

exports.boot = (app) ->

  app.post '/face', (req, res) ->
    body = JSON.parse req.body.data
    imgArr = []
    _.each req.files, (data,key)->
      imgArr.push(data)
    newFace = new Face(body.type)
    newProd = Product(body.product)
    newFace.save (err, face) ->
      newProd.isFace = face["_id"]
      newProd.save (err, product) ->
        res.send 200
        if imgArr.length
          imgArr.forEach (img, i) ->
            type = img.mime.replace("image/", "")
            path = './public/img/products/' + product["_id"]
            product.picture.push(type)
            fs.mkdir path, (err) ->
              fs.copy img.path, path + "/" + i + "." + type, (err) ->
          product.save()

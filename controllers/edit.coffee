db = require '../lib/db'
_ = require 'underscore'
nodemailer = require 'nodemailer'
fs = require "fs-extra"

{User, Product, Face, Brend, Body, New, Action} = db.models

exports.boot = (app) ->



  app.post '/brend', (req, res) ->
    body = JSON.parse req.body.data
    Brend.findById body.id, (err, brend) ->
      brend.title       = body.title
      brend.description = body.description
      brend.active      = body.active
      _.each req.files, (data,key)->
        type = data.mime.replace("image/", "")
        path = './public/img/brends/' + brend["_id"]
        brend[key] = type
        fs.mkdir path, (err) ->
          fs.copy data.path, path + "/" + key + "." + type, (err) ->
      brend.save()
      res.send 200


  app.post '/new', (req, res) ->
    body = JSON.parse req.body.data
    New.findById body.id, (err, news) ->
      news.title       = body.title
      news.descriptions = body.descriptions
      news.vetrina      = body.vetrina
      _.each req.files, (data,key)->
        type = data.mime.replace("image/", "")
        path = './public/img/news/' + news["_id"]
        news[key] = type
        fs.mkdir path, (err) ->
          fs.copy data.path, path + "/" + key + "." + type, (err) ->
      news.save()
      res.send 200



  app.post '/action', (req, res) ->
    body = JSON.parse req.body.data
    Action.findById body.id, (err, action) ->
      action.title       = body.title
      action.description = body.description
      action.active      = body.active
      action.products    = body.products
      _.each req.files, (data,key)->
        type = data.mime.replace("image/", "")
        path = './public/img/actions/' + action["_id"]
        action[key] = type
        fs.mkdir path, (err) ->
          fs.copy data.path, path + "/" + key + "." + type, (err) ->
      action.save()
      res.send 200



  app.post '/face', (req, res) ->
    body = JSON.parse req.body.data
    Product.findById body.product.findId, (err, prod) ->

    
    
      Face.findById body.type.id, (err, face) ->
        console.log "face", face
        console.log "prod", prod
        
#    newFace = new Face(body.type)
#    newProd = Product(body.product)
#    newFace.save (err, face) ->
#      newProd.isFace = face["_id"]
#      newProd.save (err, product) ->
#        res.send 200
#        _.each req.files, (data,key)->
#            type = data.mime.replace("image/", "")
#            path = './public/img/products/' + product["_id"]
#            if key == "vid"
#                product.imgVid = type
#            else
#                product.picture.push(type)
#            fs.mkdir path, (err) ->
#              fs.copy data.path, path + "/" + key + "." + type, (err) ->
#        product.save()
#        
#  app.post '/body', (req, res) ->
#    body = JSON.parse req.body.data
#    newBody = new Body(body.type)
#    newProd = Product(body.product)
#    newBody.save (err, body) ->
#      newProd.isBody = body["_id"]
#      newProd.save (err, product) ->
#        res.send 200
#        _.each req.files, (data,key)->
#            type = data.mime.replace("image/", "")
#            path = './public/img/products/' + product["_id"]
#            if key == "vid"
#                product.imgVid = type
#            else
#                product.picture.push(type)
#            fs.mkdir path, (err) ->
#              fs.copy data.path, path + "/" + key + "." + type, (err) ->
#        product.save()

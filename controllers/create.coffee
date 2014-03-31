db = require '../lib/db'
_ = require 'underscore'
nodemailer = require 'nodemailer'
fs = require "fs-extra"

{User, Product, Face, Brend, Body, New, Action} = db.models

exports.boot = (app) ->

  app.post '/action', (req, res) ->
    body = JSON.parse req.body.data
    newAction = new Action(body)
    newAction.save (err, action) ->
      _.each req.files, (data,key)->
        type = data.mime.replace("image/", "")
        path = './public/img/actions/' + action["_id"]
        action[key] = type
        fs.mkdir path, (err) ->
          fs.copy data.path, path + "/" + key + "." + type, (err) ->
      action.save()
      res.send 200
    


  app.post '/brend', (req, res) ->
    body = JSON.parse req.body.data
    newBrend = new Brend(body)
    newBrend.save (err, brend) ->
      _.each req.files, (data,key)->
        type = data.mime.replace("image/", "")
        path = './public/img/brends/' + brend["_id"]
        brend[key] = type
        fs.mkdir path, (err) ->
          fs.copy data.path, path + "/" + key + "." + type, (err) ->
      brend.save()
      res.send 200

  app.post '/news', (req, res) ->
    body = JSON.parse req.body.data
    body.images = []
    newNews = new New(body)
    newNews.save (err, news) ->
      _.each req.files, (data,key)->
        type = data.mime.replace("image/", "")
        path = './public/img/news/' + news["_id"]
#        if key == "logo"
        news[key] = type
#        else
#          news.images.push(type)
        fs.mkdir path, (err) ->
          fs.copy data.path, path + "/" + key + "." + type, (err) ->
      news.save()
      res.send 200



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
                fName = "vid"
                product.imgVid = type
            else
                fName = Number(new Date())
                nameFile = fName + "." + type
                product.picture.push(nameFile)
            fs.mkdir path, (err) ->
              fs.copy data.path, path + "/" + fName + "." + type, (err) ->
        product.save()
        
  app.post '/body', (req, res) ->
    body = JSON.parse req.body.data
    newBody = new Body(body.type)
    newProd = Product(body.product)
    newBody.save (err, body) ->
      newProd.isBody = body["_id"]
      newProd.save (err, product) ->
        res.send 200
        _.each req.files, (data,key)->
            type = data.mime.replace("image/", "")
            path = './public/img/products/' + product["_id"]
            if key == "vid"
                fName = "vid"
                product.imgVid = type
            else
                fName = Number(new Date())
                nameFile = fName + "." + type
                product.picture.push(nameFile)
            fs.mkdir path, (err) ->
              fs.copy data.path, path + "/" + fName + "." + type, (err) ->
        product.save()

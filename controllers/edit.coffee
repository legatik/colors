db = require '../lib/db'
_ = require 'underscore'
nodemailer = require 'nodemailer'
fs = require "fs-extra"
rimraf = require "rimraf"

{User, Product, Face, Brend, Body, New, Action} = db.models

exports.boot = (app) ->



  app.post '/brend', (req, res) ->
    body = JSON.parse req.body.data
    console.log "rererrer", body
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



  app.post '/body', (req, res) ->
    body = JSON.parse req.body.data
    Product.findById body.product.findId, (err, prod) ->
      delStepImg prod, body, (prodUp) ->
        updateProd prodUp, body, req, (prodUp2) ->
          deleteOldType prodUp2, (prodUp3) ->

#            Непосредственно для типа

            newBody = new Body(body.type)
            newBody.save (err, body) ->
              prodUp3.isBody = body["_id"]
              prodUp3.save ()->
                res.send 200


  app.post '/face', (req, res) ->
    body = JSON.parse req.body.data
    Product.findById body.product.findId, (err, prod) ->
      delStepImg prod, body, (prodUp) ->
        updateProd prodUp, body, req, (prodUp2) ->
          deleteOldType prodUp2, (prodUp3) ->

#            Непосредственно для типа

            newFace = new Face(body.type)
            newFace.save (err, face) ->
              console.log "HEARE@@@@@@@@@@@@@@@"
              prodUp3.isFace = face["_id"]
              prodUp3.save ()->
                res.send 200


  deleteOldType = (prod, cb) ->
    if prod.isFace
      Face.findById prod.isFace, (err, face) ->
        face.remove() if face
        prod.set('isFace', undefined)
        prod.save () ->
          cb(prod)


    if prod.isBody
      Body.findById prod.isBody, (err, body) ->
        body.remove() if body
        prod.set('isBody', undefined)
        prod.save () ->
          cb(prod)


  updateProd = (prod, body, req, cb) ->
    prod.brend = body.product.brend
    prod.cost = body.product.cost
    prod.id = body.product.id
    prod.minOpisanie = body.product.minOpisanie
    prod.obem = body.product.obem
    prod.oldCost = body.product.oldCost
    prod.opisanie = body.product.opisanie
    prod.ostatok = body.product.ostatok
    prod.primenenie = body.product.primenenie
    prod.title = body.product.title
    prod.ves = body.product.ves
    prod.vetrina = body.product.vetrina
    prod.vid = body.product.vid

    _.each req.files, (data,key)->
        type = data.mime.replace("image/", "")
        path = './public/img/products/' + prod["_id"]
        if key == "vid"
            fName = "vid"
            prod.imgVid = type
            nameFile = fName  + "." + type
        else
            fName = Number(new Date())
            nameFile = fName + key + "." + type
            prod.picture.push(nameFile)
        fs.mkdir path, (err) ->
          fs.copy data.path, path + "/" + nameFile, (err) ->
    prod.save () ->
        cb(prod)




  delStepImg = (prod, body, cb) ->
      newPicArr = []
      prod.picture.forEach (nameS)->
        check = true
        body.product.withoutImg.forEach (nameN) ->
          if nameN == nameS
            check = false
            path = './public/img/products/' + prod["_id"] + "/" + nameN
            rimraf path, (err) ->
        newPicArr.push nameS if check
      prod.picture = []
      prod.picture = newPicArr
      prod.save () ->
        cb(prod)

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


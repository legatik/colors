db = require '../lib/db'
_ = require 'underscore'
fs = require 'fs-extra'

{User, Product, Face, Brend, Body} = db.models

exports.boot = (app) ->


  app.get '/admin', (req, res) ->
      res.render 'admin/page/admin', {title: 'Админ', user: req.user, loc:'home'}
      
  app.get '/admin/page/brend', (req, res) ->
      res.render 'admin/page/brend', {title: 'Админ - бренды', user: req.user, loc:'home'}

  app.get '/admin/page/product', (req, res) ->
      res.render 'admin/page/product', {title: 'Админ - товары', user: req.user, loc:'home'}

  app.get '/admin/page/new', (req, res) ->
      res.render 'admin/page/new', {title: 'Админ - новинки', user: req.user, loc:'home'}

  app.get '/admin/page/action', (req, res) ->
      res.render 'admin/page/action', {title: 'Админ - акции', user: req.user, loc:'home'}

  app.get '/admin/q_brend', (req, res) ->
    Brend.find {}, (err, arrBrend) ->
      res.send arrBrend

  app.get '/admin/q_prod_by_name', (req, res) ->
    find = new RegExp(req.query.title, "i")
    Product.find {title: find}, (err, arrProd) ->
      res.send arrProd
      
  app.get '/admin/q_brend_by_name', (req, res) ->
    find = new RegExp(req.query.title, "i")
    Brend.find {title: find}, (err, arrBrend) ->
      res.send arrBrend
      
  app.post '/admin/fn_act_brend', (req, res) ->
    data = req.body
    Brend.findOne {_id: data.id}, (err, brend) ->
      brend.active = true if data.active == "false"
      brend.active = false if data.active == "true"
      brend.save()
      res.send 200
      
  app.post '/admin/del_brend', (req, res) ->
    data = req.body
    Brend.findOne {_id: data.id}, (err, brend) ->
      Product.find {brend:data.id}, (err, products) ->
        products.forEach (product) ->
          checkType(product, {del:true})
        res.send 200

  delIsface = (product) ->
    Face.findOne {_id: product.isFace}, (err, face) ->
      console.log "dace!!!!!!!!!!!!", face

  delIsbody = (product) ->
    Body.findOne {_id: product.isBody}, (err, body) ->
      console.log "dace!!!!!!!!!!!!", body

  checkType = (product,param) ->
    if product.isFace
      console.log "isface"
#      delIsface(product) if param.del
    if product.isBody
      console.log "isbody"
      delIsbody(product) if param.del


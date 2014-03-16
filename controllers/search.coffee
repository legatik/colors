db = require '../lib/db'
_ = require 'underscore'
fs = require 'fs-extra'

{User, Product, Face, Brend} = db.models

exports.boot = (app) ->
  app.get '/q_brend', (req, res) ->
    Brend.find {}, (err, arrBrend) ->
      res.send arrBrend

  app.post '/filter/body', (req, res) ->
    data = req.body
    Product.find {}, (err, products)-> 
      res.send products


  app.post '/filter/face', (req, res) ->
    data = req.body
    Product.find {}, (err, products)-> 
      res.send products

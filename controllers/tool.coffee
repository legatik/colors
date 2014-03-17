db = require '../lib/db'
_ = require 'underscore'
fs = require 'fs-extra'

{User, Product, Face, Brend} = db.models

exports.boot = (app) ->


  app.get '/admin', (req, res) ->
      res.render 'admin/page/admin', {title: 'Админ', user: req.user, loc:'home'}
      
  app.get '/admin/page/brend', (req, res) ->
      res.render 'admin/page/brend', {title: 'Админ - бренды', user: req.user, loc:'home'}

  app.get '/admin/page/product', (req, res) ->
      res.render 'admin/page/product', {title: 'Админ - товары', user: req.user, loc:'home'}




#  app.post '/admin/create_brend', (req, res) ->
#    console.log "req.body", req.body
#    console.log "req.body", req.body
#    
#    res.send 200
#  
#    newBrend = new Brend {title:req.query.brendName}
#    newBrend.save (err, brend) ->
#      res.send brend

  app.get '/admin/q_brend', (req, res) ->
    Brend.find {}, (err, arrBrend) ->
      res.send arrBrend


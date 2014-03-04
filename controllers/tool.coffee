db = require '../lib/db'
_ = require 'underscore'
fs = require 'fs-extra'

{User, Product, Face, Brend} = db.models

exports.boot = (app) ->

  app.get '/admin', (req, res) ->
      res.render 'admin', {title: 'Админ', user: req.user, loc:'home'}

  app.get '/admin/create_brend', (req, res) ->
    newBrend = new Brend {title:req.query.brendName}
    newBrend.save (err, brend) ->
      res.send brend

  app.get '/admin/q_brend', (req, res) ->
    Brend.find {}, (err, arrBrend) ->
      res.send arrBrend


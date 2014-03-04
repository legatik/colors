db = require '../lib/db'
_ = require 'underscore'
fs = require 'fs-extra'

{User,Product, Dish, Comment, Raiting} = db.models

exports.boot = (app) ->

  app.get '/admin', (req, res) ->
      res.render 'admin', {title: 'Админ', user: req.user, loc:'home'}


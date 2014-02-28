db = require '../lib/db'
_ = require 'underscore'
nodemailer = require 'nodemailer'

{Dish} = db.models

exports.boot = (app) ->

  app.get '/', (req, res) ->
      res.render 'index', {title: 'Colors Project', user: req.user, loc:'home'}


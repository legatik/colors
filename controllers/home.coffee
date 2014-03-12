db = require '../lib/db'
_ = require 'underscore'
nodemailer = require 'nodemailer'

{Product} = db.models

exports.boot = (app) ->

  app.get '/', (req, res) ->
    Product.find {vetrina:true}, (err, vetrina) ->
      vetrinaArr = []
      vet = Math.ceil(vetrina.length / 4)
      i = 0
      while i < vet
        ne1 = vetrina.slice(i * 4, (i * 4)+4)
        vetrinaArr.push ne1
        i++  
      res.render 'index', {title: 'Colors Project', user: req.user, loc:'home', vetrina:vetrinaArr}


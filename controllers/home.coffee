db = require '../lib/db'
_ = require 'underscore'
nodemailer = require 'nodemailer'

{Product, Brend} = db.models

exports.boot = (app) ->

  separatorFn = (arr, j) ->
    arrSend = []
    vet = Math.ceil(arr.length / j)
    i = 0
    while i < vet
      ne1 = arr.slice(i * j, (i * j)+j)
      arrSend.push ne1
      i++  
    return arrSend

  app.get '/', (req, res) ->
    Product.find {vetrina:true}, (err, vetrins) ->
      vetrinaArr = separatorFn(vetrins, 4)
      Brend.find {active:true}, (err, brends) ->
        console.log "vetrinas", brends
        brendArr = separatorFn(brends, 6)
        res.render 'index', {title: 'Colors Project', user: req.user, loc:'home', vetrina:vetrinaArr, brend:brendArr}


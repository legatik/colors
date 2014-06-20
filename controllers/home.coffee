db = require '../lib/db'
_ = require 'underscore'
nodemailer = require 'nodemailer'

{Product, Brend, Action, New} = db.models

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
    console.log "req.user", req.user
    Product.find {vetrina:true}, (err, vetrins) ->
      vetrinaArr = separatorFn(vetrins, 4)
      Brend.find {active:true}, (err, brends) ->
        Action.find {active:true}, (err, actions) ->
          New.find {vetrina:true}, (err, news) ->
            brendArr = separatorFn(brends, 6)
            res.render 'index', {title: 'Colors Project', user: req.user, loc:'home', vetrina:vetrinaArr, brend:brendArr, action:actions, news:news, user:req.user}


  app.get '/lending', (req, res) -> 
    res.render 'lending', {title: 'Colors lending', user: req.user, loc:'home'}       
    
  app.get '/popup1', (req, res) -> 
    res.render 'popup1', {title: 'Colors lending', user: req.user, loc:'home'}     
    
  app.get '/popup2', (req, res) -> 
    res.render 'popup2', {title: 'Colors lending', user: req.user, loc:'home'}        
    
  app.get '/popup3', (req, res) -> 
    res.render 'popup3', {title: 'Colors lending', user: req.user, loc:'home'}      

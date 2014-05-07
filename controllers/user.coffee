db = require '../lib/db'
_ = require 'underscore'
nodemailer = require 'nodemailer'

{Product, Brend, Action, New, User} = db.models

exports.boot = (app) ->

  app.get '/profile', (req, res) -> 
    User.findOne {_id:req.user["_id"]}, (err, user)->
      res.render 'profile', {title: 'Colors Профиль', user: user, loc:'home'}
    
  app.get '/favorites', (req, res) -> 
    res.render 'favorites', {title: 'Colors Избранное', user: req.user, loc:'home'}    
  
  app.get '/un-favorites', (req, res) -> 
    res.render 'un-favorites', {title: 'Colors Избранное', user: req.user, loc:'home'}
  
  app.get '/reviews', (req, res) -> 
    res.render 'reviews', {title: 'Colors Отзывы', user: req.user, loc:'home'}     
    
  app.get '/stockpiling', (req, res) -> 
    res.render 'stockpiling', {title: 'Colors Накопление', user: req.user, loc:'home'}      
    
  app.post '/update', (req, res) -> 
    body = req.body.data
    if req.user
      User.findOne {_id:req.user["_id"]}, (err, user)->
        user.name = body.name
        user.gender = body.gender
        user.town = body.town
        user.vk = body.vk
        user.aboutme = body.aboutme
        user.birthday = new Date body.birthday
        user.save()
        res.send 200

db = require '../lib/db'
_ = require 'underscore'
nodemailer = require 'nodemailer'

{Product, Brend, Action, New} = db.models

exports.boot = (app) ->

  app.get '/profile', (req, res) -> 
    res.render 'profile', {title: 'Colors Профиль', user: req.user, loc:'home'}
    
  app.get '/favorites', (req, res) -> 
    res.render 'favorites', {title: 'Colors Избранное', user: req.user, loc:'home'}    
  
  app.get '/un-favorites', (req, res) -> 
    res.render 'un-favorites', {title: 'Colors Избранное', user: req.user, loc:'home'}
  
  app.get '/reviews', (req, res) -> 
    res.render 'reviews', {title: 'Colors Отзывы', user: req.user, loc:'home'}     
    
  app.get '/stockpiling', (req, res) -> 
    res.render 'stockpiling', {title: 'Colors Накопление', user: req.user, loc:'home'}      

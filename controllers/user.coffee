db = require '../lib/db'
_ = require 'underscore'
nodemailer = require 'nodemailer'
fs = require "fs-extra"
rimraf = require "rimraf"

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
    console.log "req.body",req.body
    console.log "req.file",req.files
    body = JSON.parse req.body.data
    if req.user
      User.findOne {_id:req.user["_id"]}, (err, user)->
        user.name = body.name
        user.gender = body.gender
        user.town = body.town
        user.vk = body.vk
        user.aboutme = body.aboutme
        if body.birthday
          user.birthday = new Date body.birthday
        if(_.isEmpty(req.files))
          user.save()
          res.send 200
          return
        _.each req.files, (data,key)->
          type = data.mime.replace("image/", "")
          path = './public/img/users/' + user["_id"]
          console.log "keaggg", key

          if user.ava
            pathDel = path + "/ava." + user.ava
            rimraf pathDel, (err) ->
              user[key] = type
              fs.mkdir path, (err) ->
                fs.copy data.path, path + "/ava." + type, (err) ->
                  user.save()
                  res.send 200
          else
              user[key] = type
              fs.mkdir path, (err) ->
                fs.copy data.path, path + "/ava." + type, (err) ->
                  user.save()
                  res.send 200


#        user.save()
#        res.send 200

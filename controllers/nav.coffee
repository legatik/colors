db = require '../lib/db'
_ = require 'underscore'
nodemailer = require 'nodemailer'

{Dish} = db.models

exports.boot = (app) ->

  app.get '/new', (req, res) ->
      res.render 'index', {title: 'Новинки', user: req.user, loc:'home'}

  app.get '/brend', (req, res) ->
      res.render 'brands', {title: 'Бренды', user: req.user, loc:'home'}

  app.get '/face', (req, res) ->
      res.render 'search', {title: 'Для лица', user: req.user, loc:'home', search:"face"}

  app.get '/body', (req, res) ->
      res.render 'search', {title: 'Для тела', user: req.user, loc:'home', search:"body"}

  app.get '/hair', (req, res) ->
      res.render 'index', {title: 'Для волос', user: req.user, loc:'home'}

  app.get '/makeup', (req, res) ->
      res.render 'index', {title: 'Макияж', user: req.user, loc:'home'}

  app.get '/accessories', (req, res) ->
      res.render 'index', {title: 'Аксессуары', user: req.user, loc:'home'}

  app.get '/man', (req, res) ->
      res.render 'index', {title: 'Для мужчин', user: req.user, loc:'home'}

  app.get '/sets', (req, res) ->
      res.render 'index', {title: 'Наборы', user: req.user, loc:'home'}


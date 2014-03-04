db = require '../lib/db'
_ = require 'underscore'
nodemailer = require 'nodemailer'

{Dish} = db.models

exports.boot = (app) ->

  app.get '/about', (req, res) ->
      res.render 'index', {title: 'О нас', user: req.user, loc:'home'}

  app.get '/catalog', (req, res) ->
      res.render 'index', {title: 'Каталог', user: req.user, loc:'home'}

  app.get '/pay', (req, res) ->
      res.render 'index', {title: 'Доставка и оплата', user: req.user, loc:'home'}

  app.get '/action', (req, res) ->
      res.render 'index', {title: 'Акции', user: req.user, loc:'home'}

  app.get '/reviews', (req, res) ->
      res.render 'index', {title: 'Отзывы', user: req.user, loc:'home'}

  app.get '/opt', (req, res) ->
      res.render 'index', {title: 'Опт', user: req.user, loc:'home'}

  app.get '/contact', (req, res) ->
      res.render 'index', {title: 'Контакты', user: req.user, loc:'home'}


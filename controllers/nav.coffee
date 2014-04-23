db = require '../lib/db'
_ = require 'underscore'
nodemailer = require 'nodemailer'

{Brend, Action, New} = db.models

exports.boot = (app) ->

  app.get '/new', (req, res) ->
      New.find {vetrina:true}, (err, news) ->
        arrNews = separatorNews(news, 2)
        console.log "arrNews", arrNews
        res.render 'news', {title: 'Новинки', user: req.user, loc:'home', news:arrNews}

  app.get '/brend', (req, res) ->
    brendId = req.query.key
    Brend.find {active:true}, (err, brends) ->
      res.render 'brands', {title: 'Бренды', user: req.user, loc:'home', brends, brendId}

  app.get '/face', (req, res) ->
    Action.findOne {active:true}, (err, action) ->
      console.log "action",action
      data = req.query
      console.log "data", data
      sort = ""
      type = ""
      pType = ""
      sort = data.sort if data.sort
      type = data.type if data.type
      pType = data.pType if data.pType
      res.render 'search', {title: 'Для лица', user: req.user, loc:'home', search:"face", sort, pType, type}

  app.get '/body', (req, res) ->
    data = req.query
    console.log "data", data
    sort = ""
    type = ""
    pType = ""
    sort = data.sort if data.sort
    type = data.type if data.type
    pType = data.pType if data.pType
    res.render 'search', {title: 'Для тела', user: req.user, loc:'home', search:"body", sort, pType, type}

  app.get '/hair', (req, res) ->
    data = req.query
    console.log "data", data
    sort = ""
    type = ""
    pType = ""
    sort = data.sort if data.sort
    type = data.type if data.type
    pType = data.pType if data.pType
    res.render 'search', {title: 'Для волос', user: req.user, loc:'home', search:"body", sort, pType, type}

  app.get '/makeup', (req, res) ->
    data = req.query
    console.log "data", data
    sort = ""
    type = ""
    pType = ""
    sort = data.sort if data.sort
    type = data.type if data.type
    pType = data.pType if data.pType
    res.render 'search', {title: 'Макияж', user: req.user, loc:'home', search:"makeup", sort, pType, type}

  app.get '/accessories', (req, res) ->
    data = req.query
    console.log "data", data
    sort = ""
    type = ""
    pType = ""
    sort = data.sort if data.sort
    type = data.type if data.type
    pType = data.pType if data.pType
    res.render 'search', {title: 'Аксессуары', user: req.user, loc:'home', search:"access", sort, pType, type}

  app.get '/man', (req, res) ->
    data = req.query
    console.log "data", data
    sort = ""
    type = ""
    pType = ""
    sort = data.sort if data.sort
    type = data.type if data.type
    pType = data.pType if data.pType
    res.render 'search', {title: 'Для мужчин', user: req.user, loc:'home', search:"forman", sort, pType, type}

  app.get '/sets', (req, res) ->
    data = req.query
    console.log "data", data
    sort = ""
    type = ""
    pType = ""
    sort = data.sort if data.sort
    type = data.type if data.type
    pType = data.pType if data.pType
    res.render 'search', {title: 'Наборы', user: req.user, loc:'home', search:"set", sort, pType, type}

  app.get '/promotions', (req, res) ->
    actionId = req.query.key
    Action.find {active:true}, (err, actions) ->
      res.render 'promotions', {title: 'Акции', user: req.user, loc:'home', actions, actionId}


  separatorNews = (arr, j) ->
    arrSend = []
    vet = Math.ceil(arr.length / j)
    i = 0
    while i < vet
      ne1 = arr.slice(i * j, (i * j)+j)
      obj =
        type : Math.round(Math.random() *1) + 1
        arr  : ne1
      arrSend.push obj
      i++  
    return arrSend

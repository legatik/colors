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

  app.get '/product', (req, res) ->
    Action.count {}, (err, count)->
      skip = Math.floor(Math.random() * count)
      console.log 'skip',skip
      Action.find({active:true}).skip(skip).limit(1).exec (err, actionArr) ->
        if actionArr.length
          action = "../img/actions/"+actionArr[0]._id+"/poster."+actionArr[0].poster+""
        console.log "action", action
        data = req.query
        console.log "data", data
        search = data.search
        sort = ""
        type = ""
        pType = ""
        sort = data.sort if data.sort
        type = data.type if data.type
        pType = data.pType if data.pType
        res.render 'search', {title: 'Для лица', user: req.user, loc:'home', search, sort, pType, type, action}


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

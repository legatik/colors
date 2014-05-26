db = require '../lib/db'
_ = require 'underscore'
nodemailer = require 'nodemailer'
fs = require "fs-extra"
passport = require 'passport'

{User, Product, Brend, New, Action} = db.models

exports.boot = (app) ->

  app.post '/action', (req, res) ->
    body = JSON.parse req.body.data
    newAction = new Action(body)
    newAction.save (err, action) ->
      _.each req.files, (data,key)->
        type = data.mime.replace("image/", "")
        path = './public/img/actions/' + action["_id"]
        console.log "keaggg", key
        action[key] = type
        fs.mkdir path, (err) ->
          fs.copy data.path, path + "/" + key + "." + type, (err) ->
      action.save()
      res.send 200



  app.post '/brend', (req, res) ->
    body = JSON.parse req.body.data
    newBrend = new Brend(body)
    newBrend.save (err, brend) ->
      _.each req.files, (data,key)->
        type = data.mime.replace("image/", "")
        path = './public/img/brends/' + brend["_id"]
        brend[key] = type
        fs.mkdir path, (err) ->
          fs.copy data.path, path + "/" + key + "." + type, (err) ->
      brend.save()
      res.send 200

  app.post '/news', (req, res) ->
    body = JSON.parse req.body.data
    body.images = []
    newNews = new New(body)
    newNews.save (err, news) ->
      _.each req.files, (data,key)->
        type = data.mime.replace("image/", "")
        path = './public/img/news/' + news["_id"]
#        if key == "logo"
        news[key] = type
#        else
#          news.images.push(type)
        fs.mkdir path, (err) ->
          fs.copy data.path, path + "/" + key + "." + type, (err) ->
      news.save()
      res.send 200


  app.post '/product', (req, res) ->
    body = JSON.parse req.body.data
    firstTypeProd = body.typeProd.charAt(0).toUpperCase()
    typeProd = firstTypeProd + body.typeProd.substr(1)
    modelType = db.models[typeProd]
    newType = new modelType(body.type)
    newProd = Product(body.product)
    newType.save (err, typeObj) ->
      idType = "is" + typeProd
      newProd[idType] = typeObj["_id"]
      newProd.save (err, product) ->
        res.send 200
        _.each req.files, (data,key)->
            type = data.mime.replace("image/", "")
            path = './public/img/products/' + product["_id"]
            if key == "vid"
                fName = "vid"
                product.imgVid = type
                nameFile = fName  + "." + type
            else
                fName = Number(new Date())
                nameFile = fName + key + "." + type
                product.picture.push(nameFile)
            fs.mkdir path, (err) ->
              fs.copy data.path, path + "/" + nameFile, (err) ->
        product.save()


  app.post '/step1_user', (req, res) ->
    email = req.body.email
    User.findOne ({email:email}), (err, user) ->
      if user
        res.send "Пользователь с такой почтой уже зарегестрирован"
        return
        password = Number(new Date()) + Math.ceil(Math.random()*9)
        obj = {
          email        : email
          password     : password
          confirm      : false
          date_request : new Date()
          name          : ""
          vk            : ""
          gender        : ""
          town          : ""
          aboutme       : ""
        }
        user = new User(obj)
        user.save()

        smtpTransport = nodemailer.createTransport("SMTP",
          service: "Gmail"
          auth:
            user: "colors.sup@gmail.com"
            pass: "colors1!1"
        )

        mailOptions =
          from: "mir.cook.sup@gmail.com"
          to: email
          subject: "Регестрация" # Subject line
          html: "<div>Привет</div><div><a href='http://localhost:3000/create/confirm/?pass="+password+"'>перейти по ссылке</a></div><div>Ваш пароль: "+password+"</div>"

        smtpTransport.sendMail mailOptions, (error, response) ->
          if error
            console.log error
          else
            console.log "Message sent: " + response.message
            res.send "Заявка отправленна. Проверьте свою электронную почту"

  app.post '/send_pass', (req, res) ->
    email = req.body.email
    password = Number(new Date()) + Math.ceil(Math.random()*9)
    User.findOne ({email:email}), (err, user) ->
      if !user
        res.send "Пользователь с такой почтой не зарегестрирован"
        return
      user.password = password
      user.save()
      smtpTransport = nodemailer.createTransport("SMTP",
        service: "Gmail"
        auth:
          user: "colors.sup@gmail.com"
          pass: "colors1!1"
      )
      mailOptions =
        from: "mir.cook.sup@gmail.com"
        to: email
        subject: "Востановление пароля" # Subject line
        html: "<div>Привет</div><div>><div>Ваш пароль: "+password+"</div>"
      smtpTransport.sendMail mailOptions, (error, response) ->
        if error
          console.log error
        else
          console.log "Message sent: " + response.message
          res.send "Пароль выслан вам на почту."


  app.get '/confirm', (req, res, next) ->
    pass = req.query.pass
    User.findOne ({password:pass}), (err, user) ->
      if !user
        res.redirect "/"
        return
      if !user.confirm
        user.confirm = true
        user.registered_on = new Date()
      user.save (err, u)->
        req.body = {
          email:u.email
          password:u.password
        }
        passport.authenticate("local", (err, user, info) ->
          if user
            req.logIn user, (err) ->
              res.redirect "/"
          else
            res.redirect "/"
        ) req, res, next


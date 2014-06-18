db = require '../lib/db'
_ = require 'underscore'
nodemailer = require 'nodemailer'
fs = require "fs-extra"
rimraf = require "rimraf"

{Product, Brend, Action, New, User, Cart, Voucher} = db.models

exports.boot = (app) ->

  app.get '/profile', (req, res) ->
    User.findOne {_id:req.user["_id"]}, (err, user)->
      res.render 'profile', {title: 'Colors Профиль', user: user, loc:'home'}

  app.get '/favorites', (req, res) ->
    User.findOne {_id:req.user["_id"]}, (err, user)->
      res.render 'favorites', {title: 'Colors Избранное', user: user, loc:'home'}

  app.get '/un-favorites', (req, res) ->
    res.render 'un-favorites', {title: 'Colors Избранное', user: req.user, loc:'home'}

  app.get '/reviews', (req, res) ->
    res.render 'reviews', {title: 'Colors Отзывы', user: req.user, loc:'home'}

  app.get '/cart', (req, res) ->
    if req.user
      User.findById req.user["_id"], (err, user) ->
        if user.cart
          Cart.findById(user.cart)
          .populate("products")
          .exec (err, cart) ->
            products = cart.products
            res.render 'cart', {title: 'Colors Карзина', user: req.user, loc:'home', products:products}
        else
          res.render 'cart', {title: 'Colors Карзина', user: req.user, loc:'home', products:[]}
    else
      res.render 'cart', {title: 'Colors Карзина', user: req.user, loc:'home', products:[]}
          
          


  app.get '/stockpiling', (req, res) ->
    res.render 'stockpiling', {title: 'Colors Накопление', user: req.user, loc:'home'}

  app.post '/get/favorites', (req, res) ->
    arrId = req.body.prodArr
    Product.find ({'_id': { $in: arrId}}), (err, products) ->
      res.send products

  app.post '/get/tow_favorites', (req, res) ->
    if req.user
      arrId = req.body.prodArr
      User.findOne {_id:req.user["_id"]}, (err, user)->
        Product.find({'_id': { $in: user.favorites}}).limit(2).exec (err, products) ->
          Product.find({'_id': { $in: user.favorites}}).count().exec (err, col) ->
            res.send {user:true, products:products, col:col}
    else
      res.send {user:false}

  app.post '/get/tow_cart', (req, res) ->
    if req.user
      User.findOne({_id:req.user["_id"]})
      .populate("cart")
      .exec (err, user)->
        if user.cart
          Product.find({'_id': { $in: user.cart.products}}).limit(2).exec (err, products) ->
            Product.find({'_id': { $in: user.cart.products}}).count().exec (err, col) ->
              res.send {user:true, products:products, col:col}
        else
          res.send {user:true, products:[], col:0}
    else
      res.send {user:false}


  app.post '/get/to_cart_fav', (req, res) ->
    if req.user
      User.findOne {_id:req.user["_id"]}, (err, user)->
        if user.cart
          Cart.findById user.cart, (err,cart) ->
            cart.products  = _.uniq cart.products
            user.favorites.forEach (idf) ->
              check = true
              cart.products.forEach (idc) ->
                check = false if idc.toString() is idf.toString()
              cart.products.push(idf) if check
            cart.save()
            user.favorites = []
            user.save()
            res.send {st:true}
        else
          console.log "net"
          newCart = 
            user     : user["_id"]
            products : user.favorites
          newCart = new Cart(newCart)
          newCart.save (err, nCart) ->
            user.favorites = []
            user.cart = nCart["_id"]
            user.save()
            res.send {st:true}
    else
      res.send {st:false}

  app.post '/get/tow_favorites_byId', (req, res) ->
    arrId = req.body.prodArr
    Product.find({'_id': { $in: arrId}}).limit(2).exec (err, products) ->
      res.send products

  app.post '/remove_favorites', (req, res) ->
    arrId = req.body.idDel
    if req.user
      User.findOne {_id:req.user["_id"]}, (err, user)->
        newArr = []
        user.favorites.forEach (id) ->
          newArr.push(id) if arrId.toString() != id.toString()
        user.favorites = []
        user.favorites = newArr
        user.save()
        res.send 200

  app.post '/remove_cart', (req, res) ->
    arrId = req.body.idDel
    if req.user
      User.findOne {_id:req.user["_id"]}, (err, user)->
        Cart.findById user.cart, (err, cart) ->
          newArr = []
          cart.products.forEach (id) ->
            newArr.push(id) if arrId.toString() != id.toString()
          cart.products = []
          cart.products = newArr
          cart.save()
          res.send 200



  app.post '/update', (req, res) ->
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

  app.post '/check_voucher', (req, res) ->
    data = req.body
    
    Voucher.findOne {code:data.code, active:true}, (err, voucher) ->
      if voucher
        res.send {st:true, v:voucher}
        return
      res.send {st:false}
        
    

#        user.save()
#        res.send 200


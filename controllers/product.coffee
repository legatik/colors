db = require '../lib/db'
_ = require 'underscore'

{Product, Brend, Action, New, User} = db.models

exports.boot = (app) ->
  app.get '/:idProd', (req, res) ->
    idProd = req.params.idProd
    if req.user
      User.findById req.user["_id"], (err, user) ->
        if user
          check = true
          user.favorites.forEach (idInFav) ->
            check = false if idInFav.toString() is idProd
          Product.findById idProd, (err, product) ->
            if product
              res.render 'product', {title: 'Colors - ' + product.title, product:product, user:user, favAdded:check}
            else
              res.send 404
    else
      Product.findById idProd, (err, product) ->
        res.render 'product', {title: 'Colors - ' + product.title, product:product, user:"", favAdded:""}
      
  app.post '/addFavoritesUser/:idProd', (req, res) ->
    if req.user
      idProd = req.params.idProd
      User.findById req.user["_id"], (err, user) ->
        if user
          check = true
          user.favorites.forEach (idInFav) ->
            check = false if idInFav.toString() is idProd
          if check
            user.favorites.push idProd
            user.save()
            res.send {err:null} 
          else
            res.send {err:true}
        else
          res.send {err:true}
    else
      res.send {err:true}

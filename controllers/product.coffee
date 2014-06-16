db = require '../lib/db'
_ = require 'underscore'

{Product, Brend, Action, New, User, Cart} = db.models

exports.boot = (app) ->
  app.get '/:idProd', (req, res) ->
    idProd = req.params.idProd
    if req.user
      User.findById(req.user["_id"])
      .populate("cart")
      .exec (err, user) ->
        if user
          check = true
          checkCart = true
          user.favorites.forEach (idInFav) ->
            check = false if idInFav.toString() is idProd
          user.cart?.products.forEach (idPrCart) ->
            checkCart = false if idPrCart.toString() is idProd
          Product.findById idProd, (err, product) ->
            if product
              res.render 'product', {title: 'Colors - ' + product.title, product:product, user:user, favAdded:check, cartAdded:checkCart}
            else
              res.send 404
    else
      Product.findById idProd, (err, product) ->
        res.render 'product', {title: 'Colors - ' + product.title, product:product, user:"", favAdded:"", cartAdded:""}
      
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
      
  app.post '/addCartUser/:idProd', (req, res) ->
    if req.user
      idProd = req.params.idProd
      User.findById req.user["_id"], (err, user) ->
        if user
            if user.cart
                Cart.findById (user.cart), (err, cart) ->
                  check = true
                  cart.products.forEach (idInFav) ->
                    check = false if idInFav.toString() is idProd
                  if check
                    cart.products.push(idProd)
                    cart.save()
                    res.send {st:true}
            else
                cart = new Cart({products:[idProd]})
                cart.save (err, nCart) ->
                    user["cart"] = nCart["_id"]
                    user.save()
                    res.send {st:true}
        else
            res.send {st:false}
        

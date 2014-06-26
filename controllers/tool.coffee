db = require '../lib/db'
_ = require 'underscore'
fs = require 'fs-extra'
rimraf = require "rimraf"

{User, Product, Face, Brend, Body, Action, New, Makeup, Forman, Set, Access, Hair, Comment, PComment, Voucher} = db.models

exports.boot = (app) ->


  app.get '/admin', (req, res) ->
      res.render 'admin/page/admin', {title: 'Админ', user: req.user, loc:'home'}
      
  app.get '/admin/page/brend', (req, res) ->
      res.render 'admin/page/brend', {title: 'Админ - бренды', user: req.user, loc:'home'}

  app.get '/admin/page/product', (req, res) ->
      res.render 'admin/page/product', {title: 'Админ - товары', user: req.user, loc:'home'}

  app.get '/admin/page/new', (req, res) ->
      res.render 'admin/page/new', {title: 'Админ - новинки', user: req.user, loc:'home'}

  app.get '/admin/page/action', (req, res) ->
      res.render 'admin/page/action', {title: 'Админ - акции', user: req.user, loc:'home'}

  app.get '/admin/page/user', (req, res) ->
      User.find {confirm:true}, (err, users) ->
        res.render 'admin/page/user', {title: 'Админ - акции', user: req.user, loc:'home', users}

  app.get '/admin/page/comments', (req, res) ->
      res.render 'admin/page/comments', {title: 'Админ - Комментарии', user: req.user, loc:'home'}

  app.get '/admin/page/pComments', (req, res) ->
      res.render 'admin/page/pComments', {title: 'Админ - Комментарии', user: req.user, loc:'home'}

  app.get '/admin/page/voucher', (req, res) ->
      res.render 'admin/page/vouchers', {title: 'Админ - Промокоды', user: req.user, loc:'home'}


  app.get '/admin/edit/brend/:brendId', (req, res) ->
    brendId = req.params.brendId
    Brend.findById brendId , (err, brend) ->
      res.render 'admin/edit/brend', {title: 'Админ - редактирование брендов', user: req.user, brend:brend}

  app.get '/admin/edit/action/:actionId', (req, res) ->
    actionId = req.params.actionId
    Action.findById(actionId)
    .populate("products")
    .exec (err, action) ->
      console.log "action",action
      res.render 'admin/edit/action', {title: 'Админ - редактирование акций', user: req.user, action:action}

  app.get '/admin/edit/product/:prodId', (req, res) ->
    prodId = req.params.prodId
    Product.findById prodId , (err, product) ->
      checkType product, {edit:true}, (type) ->
        res.render 'admin/edit/product', {title: 'Админ - редактирование продукта', user: req.user, prod:product, type:type}



  app.get '/admin/edit/new/:newId', (req, res) ->
    newId = req.params.newId
    New.findById newId , (err, news) ->
      res.render 'admin/edit/new', {title: 'Админ - редактирование новостей', user: req.user, news:news}

  app.get '/admin/q_brend', (req, res) ->
    Brend.find {}, (err, arrBrend) ->
      res.send arrBrend

  app.get '/admin/q_prod_by_name', (req, res) ->
    find = new RegExp(req.query.title, "i")
    Product.find {title: find}, (err, arrProd) ->
      res.send arrProd

  app.get '/admin/q_new_by_name', (req, res) ->
    find = new RegExp(req.query.title, "i")
    New.find {title: find}, (err, arrNews) ->
      res.send arrNews

      
  app.get '/admin/q_brend_by_name', (req, res) ->
    find = new RegExp(req.query.title, "i")
    Brend.find {title: find}, (err, arrBrend) ->
      res.send arrBrend

  app.get '/admin/q_action_by_name', (req, res) ->
    find = new RegExp(req.query.title, "i")
    Action.find {title: find}, (err, arrAction) ->
      res.send arrAction

  app.get '/admin/q_comments_by_com', (req, res) ->
    find = new RegExp(req.query.title, "i")
    Comment.find {text: find}, (err, arrComm) ->
      res.send arrComm

  app.get '/admin/q_pComments_by_com', (req, res) ->
    find = new RegExp(req.query.title, "i")
    PComment.find {text: find}, (err, arrComm) ->
      res.send arrComm

      
  app.post '/admin/fn_act_brend', (req, res) ->
    data = req.body
    Brend.findOne {_id: data.id}, (err, brend) ->
      brend.active = true if data.active == "false"
      brend.active = false if data.active == "true"
      brend.save()
      res.send 200

  app.post '/admin/fn_vet_prod', (req, res) ->
    data = req.body
    Product.findOne {_id: data.id}, (err, prod) ->
      prod.vetrina = true if data.active == "false"
      prod.vetrina = false if data.active == "true"
      prod.save()
      res.send 200

  app.post '/admin/fn_act_action', (req, res) ->
    data = req.body
    Action.findOne {_id: data.id}, (err, act) ->
      console.log "act", act
      act.active = true if data.active == "false"
      act.active = false if data.active == "true"
      act.save()
      res.send 200

  app.post '/admin/fn_new_action', (req, res) ->
    data = req.body
    New.findOne {_id: data.id}, (err, news) ->
      news.vetrina = true if data.active == "false"
      news.vetrina = false if data.active == "true"
      news.save()
      res.send 200

      
  app.post '/admin/del_brend', (req, res) ->
    data = req.body
    Brend.findOne {_id: data.id}, (err, brend) ->
      Product.find {brend:data.id}, (err, products) ->
        products.forEach (product) ->
          checkType(product, {del:true})
        path = './public/img/brends/' + brend["_id"]
        brend.remove()
        rimraf path, (err) ->
          res.send 200


  app.post '/admin/del_action', (req, res) ->
    data = req.body
    Action.findOne {_id: data.id}, (err, action) ->
      path = './public/img/actions/' + action["_id"]
      action.remove()
      rimraf path, (err) ->
        res.send 200

  app.post '/admin/del_com', (req, res) ->
    data = req.body
    console.log "data", data
    Comment.findOne {_id: data.id}, (err, com) ->
      com.remove()
      res.send 200
      
  app.post '/admin/del_pCom', (req, res) ->
    data = req.body
    PComment.findOne {_id: data.id}, (err, pcom) ->
      arrCom = pcom.comments
      pcom.remove()
      Comment.find { _id: { $in: arrCom } }, (err, comms) ->
        comms.forEach (com) ->
          com.remove()
        res.send 200
      
      
  app.post '/admin/del_news', (req, res) ->
    data = req.body
    New.findOne {_id: data.id}, (err, news) ->
      path = './public/img/news/' + news["_id"]
      news.remove()
      rimraf path, (err) ->
        res.send 200


  app.post '/admin/del_product', (req, res) ->
    data = req.body
    Product.findOne {_id: data.id}, (err, product) ->
      checkType(product, {del:true})
      res.send 200



  app.post '/admin/edit/brend/del/file', (req, res) ->
    id = req.body.brend
    key = req.body.key
    Brend.findById id, (err, brend) ->
      path = './public/img/brends/' + id + "/" + key + "." + brend[key]
      rimraf path, (err) ->
        res.send 200

  app.post '/admin/edit/new/del/file', (req, res) ->
    id = req.body.brend
    key = req.body.key
    New.findById id, (err, news) ->
      path = './public/img/news/' + id + "/" + key + "." + news[key]
      rimraf path, (err) ->
        res.send 200


  app.post '/admin/edit/action/del/file', (req, res) ->
    id = req.body.brend
    key = req.body.key
    Action.findById id, (err, action) ->
      path = './public/img/actions/' + id + "/" + key + "." + action[key]
      rimraf path, (err) ->
        res.send 200



  delProduct = (product) ->
    path = './public/img/products/' + product["_id"]
    rimraf path, (err) ->
    product.remove()
  
  delIsface = (product) ->
    Face.findOne {_id: product.isFace}, (err, face) ->
      face.remove() if face
      delProduct(product)

  delIsbody = (product) ->
    Body.findOne {_id: product.isBody}, (err, body) ->
      body.remove() if body
      delProduct(product)

  delIsset = (product) ->
    Set.findOne {_id: product.isSet}, (err, set) ->
      set.remove() if set
      delProduct(product)

  delIsmakeup = (product) ->
    Makeup.findOne {_id: product.isMakeup}, (err, makeup) ->
      makeup.remove() if makeup
      delProduct(product)

  delIsaccess = (product) ->
    Access.findOne {_id: product.isAccess}, (err, access) ->
      access.remove() if access
      delProduct(product)

  delIsforman = (product) ->
    Forman.findOne {_id: product.isForman}, (err, forman) ->
      forman.remove() if forman
      delProduct(product)


 #For Edit

  editFace = (product, cb) ->
    Face.findOne {_id: product.isFace}, (err, face) ->
      type =
        type : "face"
        data : face
      cb(type) if face

  editBody = (product, cb) ->
    Body.findOne {_id: product.isBody}, (err, body) ->
      type =
        type : "body"
        data : body
      cb(type) if body
      

  editMakeup = (product, cb) ->
    Makeup.findOne {_id: product.isMakeup}, (err, body) ->
      type =
        type : "makeup"
        data : body
      cb(type) if body



  editSet = (product, cb) ->
    Set.findOne {_id: product.isSet}, (err, body) ->
      type =
        type : "set"
        data : body
      cb(type) if body

  editAccess = (product, cb) ->
    Access.findOne {_id: product.isAccess}, (err, body) ->
      type =
        type : "access"
        data : body
      cb(type) if body


  editForman = (product, cb) ->
    Forman.findOne {_id: product.isForman}, (err, body) ->
      type =
        type : "forman"
        data : body
      cb(type) if body
      
      
  checkType = (product, param, cb) ->
    if product.isFace
      console.log "isface"
      delIsface(product) if param.del
      editFace(product, cb)  if param.edit
      
    if product.isBody
      console.log "isbody"
      delIsbody(product) if param.del
      editBody(product, cb) if param.edit
      
    if product.isMakeup
      console.log "isMakeup"
      delIsmakeup(product) if param.del
      editMakeup(product, cb)  if param.edit
      
    if product.isSet
      console.log "isSet"
      delIsset(product) if param.del
      editSet(product, cb) if param.edit
      
    if product.isAccess
      console.log "isAccess"
      delIsaccess(product) if param.del
      editAccess(product, cb)  if param.edit
      
    if product.isForman
      console.log "isForman"
      delIsforman(product) if param.del
      editForman(product, cb) if param.edit


  app.post '/admin/del_user', (req, res) ->
    data = req.body
    User.findOne {_id: data.id}, (err, user) ->
      console.log "user", user
      user.remove()
      res.send 200

#  app.get '/updateFavUser', (req, res) ->
#    User.findById "536f8dff96a422ec11000001", (err, user) ->
#      Product.find {}, (err, pr) ->
#        pr.forEach (p) ->
#          user.favorites.push p["_id"]
#        user.save()
#        res.send 200


#  app.get '/updatecost', (req, res) ->
#    console.log "@@@@@@@"
#    Product.find {}, (err, pr) ->
#      pr.forEach (p) ->
#        p.cost = 100
#        p.save()


#  app.get '/updatecost', (req, res) ->
#    Product.find {}, (err, pr) ->
#      pr.forEach (p) ->
#        p.cost = 100
#        p.save()
    
    
#  app.get '/updateact', (req, res) ->
#    Action.findById "5336fb66bd0431571f000001", (err, action) ->
#      Product.find {}, (err, prods) ->
#        prods.forEach (p) ->
#          console.log "s", p["_id"]
#          action.products.push(p["_id"])
#        console.log "action",action
#        action.save()
    
  app.post '/admin/create_voucher', (req, res) ->
    data = req.body
    voucher = new Voucher(data)
    voucher.save()
    res.send 200
    
  app.post '/admin/get_vouchers', (req, res) ->
    Voucher.find {}, (err, vouchers) -> 
     console.log "vouchers", vouchers
     res.send vouchers
     
  app.post '/admin/chanch_voucher_active', (req, res) ->
    data = req.body
    Voucher.findOne data.id, (err, voucher) -> 
      if voucher
        voucher.active = true if data.active == "false"
        voucher.active = false if data.active == "true"
        voucher.save()
      res.send 200

  app.post '/admin/remove_voucher', (req, res) ->
    data = req.body
    Voucher.findOne data.id, (err, voucher) -> 
      voucher.remove() if voucher
      res.send 200
     

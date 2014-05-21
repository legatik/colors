db = require '../lib/db'
_ = require 'underscore'
fs = require 'fs-extra'

{User, Product, Brend, Action} = db.models

exports.boot = (app) ->
  getIds = (arr) ->
    obj = _.groupBy arr, (d) ->
      d['_id']
    return  _.keys(obj)

  getFilter = (data) ->
    filter = {}
    _.each data, (d, key) ->
      if key isnt 'podType' and key isnt 'Type'
        filter[key] = $in: d
      filter.Type = data.Type  if data.Type
      filter.podType = data.podType  if data.podType
    filter

  getProductFilter = (data, ids, idKey) ->
    filter = {}
    if idKey
      filter[idKey] = {$in: ids}
    if data
      filter.cost = {$lte: data.max_price, $gte: data.min_price}
      filter.brend = {$in: data.brend} if data.brend
      filter.title = new RegExp(data.title, "i")
    filter

  getSort = (data) ->
      sort = {}
      if data
        sort[data.sort] = 1
      sort

  app.get '/q_brend', (req, res) ->
    Brend.find {}, (err, arrBrend) ->
      res.send arrBrend

#  app.post '/filter', (req, res) ->
#    data = req.body
#    firstTypeProd = data.type.charAt(0).toUpperCase()
#    typeProd = firstTypeProd + data.type.substr(1)
#    console.log "typeProd",typeProd
#    skip = data.skip
#    db.models[typeProd].find {}, (err, bodys) ->
#      ids = getIds(bodys)
#      podTypeProd = "is" + typeProd
#      product_filter = getProductFilter(data.product, ids, podTypeProd)
#      sort = getSort(data.product)
#      Product.find(product_filter)
#      .limit(24)
#      .skip(skip)
#      .sort(sort)
#      .exec (err, products) ->
#        res.send products

  app.post '/filter', (req, res) ->
    data = req.body
    skip = data.skip
    firstTypeProd = data.type.charAt(0).toUpperCase()
    typeProd = firstTypeProd + data.type.substr(1)
    special_filter = getFilter(data.special)
    db.models[typeProd].find special_filter, (err, prodArr) ->
      ids = getIds(prodArr)
      podTypeProd = "is" + typeProd
      product_filter = getProductFilter(data.product, ids, podTypeProd)
      sort = getSort(data.product)
      Product.find(product_filter)
      .limit(24)
      .skip(skip)
      .sort(sort)
      .exec (err, products) ->
        console.log "products", products.length
        res.send products

  app.post '/productByBrend', (req, res) ->
    brendId = req.body.key
    data =  req.body.filter
    skip = req.body.skip
    product_filter = getProductFilter(data)
    product_filter.brend = brendId
    sort = getSort(data)
    Product.find(product_filter)
    .limit(24)
    .skip(skip)
    .sort(sort)
    .exec (err, products) ->
      res.send products

  app.post '/productByAction', (req, res) ->
    actionId = req.body.key
    data =  req.body.filter
    skip = req.body.skip
    product_filter = getProductFilter(data)
    sort = getSort(data)
    Action.findById actionId, (err, action) ->
      if !action
        res.send []
      else
        product_filter._id = {$in: action.products}
        Product.find(product_filter)
        .limit(24)
        .skip(skip)
        .sort(sort)
        .exec (err, products) ->
          res.send products


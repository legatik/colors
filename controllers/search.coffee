db = require '../lib/db'
_ = require 'underscore'
fs = require 'fs-extra'

{User, Product, Face, Brend, Body} = db.models

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

  app.post '/filter/body', (req, res) ->
    data = req.body
    Body.find {}, (err, bodys) ->
      ids = getIds(bodys)
      product_filter = getProductFilter(data.product, ids, 'isBody')
      sort = getSort(data.product)
      Product.find(product_filter)
      .sort(sort)
      .exec (err, products) ->
        res.send products

  app.post '/filter/face', (req, res) ->
    data = req.body
    special_filter = getFilter(data.special)
    Face.find special_filter, (err, faces) ->
      ids = getIds(faces)
      product_filter = getProductFilter(data.product, ids, 'isFace')
      sort = getSort(data.product)
      Product.find(product_filter)
      .sort(sort)
      .exec (err, products) ->
        res.send products

  app.post '/productByBrend', (req, res) ->
    brendId = req.body.key
    data =  req.body.filter
    product_filter = getProductFilter(data)
    product_filter.brend = brendId
    sort = getSort(data)
    Product.find(product_filter)
    .sort(sort)
    .exec (err, products) ->
      res.send products

  app.post '/productByAction', (req, res) ->
    actionId = req.body.key
    data =  req.body.filter
    console.log "actionId", actionId
    console.log "data", data
    Product.find {} , (err, arr) ->
      res.send arr
    

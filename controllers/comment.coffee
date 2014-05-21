db = require '../lib/db'
_ = require 'underscore'

{User, Product, Brend, New, Action, PComment} = db.models

exports.boot = (app) ->
  app.post '/create/pComment', (req, res) ->
    if req.user
      body = req.body
      newCom = new PComment(body)
      console.log "newCom", newCom
      newCom.save (err, com) ->
        res.send com
      
  app.post '/get/comments', (req, res) ->
    id = req.body.id
    PComment.find({product:id})
    .exec (err, comms) ->
      res.send comms
    



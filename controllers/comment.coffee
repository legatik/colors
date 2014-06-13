db = require '../lib/db'
_ = require 'underscore'

{User, Product, Brend, New, Action, PComment, Comment} = db.models

exports.boot = (app) ->
  app.post '/create/pComment', (req, res) ->
    body = req.body
    newCom = new PComment(body)
    newCom.save (err, com) ->
      if req.user
        User.findById req.user["_id"], (err, user) ->
          res.send {com:com, user:user}
      else
        res.send {com:com, user:false}
      
  app.post '/get/comments', (req, res) ->
    id = req.body.id
    PComment.find({product:id})
    .populate("comments")
    .populate("user")
    .exec (err, comms) ->
      res.send comms

  app.post '/yon', (req, res) ->
    id = req.body.id
    st = req.body.st
    if req.user
      User.findById(req.user["_id"])
      .exec (err, user) ->
        check = true
        user.yesorno.forEach (idyor) ->
          check = false if idyor.toString() is id.toString()
        if check
          user.yesorno.push(id)
          user.save()
          key = req.body.key
          PComment.findById(id)
          .exec (err, com) ->
            tmp = com[key] + 1
            com[key] = tmp
            com.save()
            res.send com
    if st
      key = req.body.key
      PComment.findById(id)
      .exec (err, com) ->
        tmp = com[key] + 1
        com[key] = tmp
        com.save()
        res.send com
    
    
  app.post '/create/comment', (req, res) ->
    data = req.body.data
    id   = req.body.id
    PComment.findById id, (err, pCom) ->
      if data.user
        User.findById data.user, (err, user) ->
          data.ava = user.ava if user.ava
          comment = new Comment(data)
          comment.save (err, com) ->
            pCom.comments.push com['_id']
            pCom.save (err, s) ->
            res.send com
        
        
      

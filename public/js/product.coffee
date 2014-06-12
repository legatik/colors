$(document).ready () ->
  arrViwe = []
  cookieArr = []
#  $.cookie "colors_favorites", null
  cookies_fav =  $.cookie "colors_favorites"
  gUser = $("#firstData").attr("user")
  gUser = JSON.parse(gUser) if gUser
  gProduct = $("#firstData").attr("product")
  gProduct = JSON.parse(gProduct) if gProduct
  check = true

  getComments = () ->
    $.ajax
      type    : 'POST'
      data    : {id:gProduct["_id"]}
      url     : "/comment/get/comments"
      success : (arr) =>
        arr.forEach (data) ->
          pCommentView = new PCommentView(data)
          $("#rew-block-cont").prepend(pCommentView.render())
          pCommentView.renderComments()
          arrViwe.push pCommentView
          
  getComments()

#  if cookies_fav and cookies_fav != "null" and !userTest
  if cookies_fav and cookies_fav != "null"
    idProdtest = $(".favorites").attr("id")
    cookieArr = JSON.parse(cookies_fav)
    cookieArr.forEach (idP) ->
      check = false if idP.toString() is idProdtest.toString()
    if !check
      $(".nsetCookie").show()
      $(".setCookie").hide()
    else
      $(".nsetCookie").hide()
      $(".setCookie").show()


  $(".addFav").click ()->
    idProd = $(@).attr("id")
    url = "/product/addFavoritesUser/" + idProd
    $.ajax
      type    : 'POST'
      url     : url
      success : (data) =>
        $(".favorites").text("В избранном") if !data.err
        $(".favorites").removeClass("addFav")


  $(".setCookie").click ()->
    idProd = $(@).attr("id")
    cookieArr.push idProd
    console.log "cookieArr", cookieArr
    $.cookie "colors_favorites", JSON.stringify(cookieArr),
      expires: 7
      path:'/'
    $(".nsetCookie").show()
    $(".setCookie").hide()
  #    domain: "subdomain.yoursite.ru"
#      secure: true

  addCalssKeup = () ->
    $(".inp-rew-ob").unbind("keyup")
#    $(".inp-com").unbind("keyup")
    $(".inp-rew-ob").keyup (e) ->
      if e.which is 13
        message = false
        data = {}
        data.name = $("#inp-name-ot").val()
        data.text = $(@).val()
        message = "Введите имя" if !data.name
        message = "Введите тексит отзыва" if !data.text
        if message
          alert message
          return
        data.date     = new Date()
        data.comments = []
        data.yes      = 0
        data.no       = 0
        data.product  = gProduct["_id"]
        data.user     = gUser["_id"] if gUser
        $.ajax
          type    : 'POST'
          data    : data
          url     : "/comment/create/pComment"
          success : (data) =>
            console.log "data", data
            pCommentView = new PCommentView(data)
            $("#rew-block-cont").prepend(pCommentView.render())
            pCommentView.renderComments()
            arrViwe.push pCommentView
        
        
#    $(".inp-com").keyup (e) ->
#      if e.which is 13
#        message = false
#        data = {}
#        data.name = $("#inp-name-ot").val()
#        data.text = $(@).val()
#        data.date = new Date()
#        message = "Введите имя" if !data.name
#        message = "Введите тексит отзыва" if !data.text
#        if message
#          alert message
#          return
#        idCom = $(@).attr("idRew")
#        arrViwe.forEach (viwe) ->
#          console.log "viwe", viwe.model["_id"]
#          if viwe.model["_id"] is idCom
#            viwe.setCom(data)
          
        
      
  addCalssKeup()
      
  class PCommentView extends Backbone.View

    tagName: 'div'

    className: 'rew-block'

    template: _.template($('#pCommentTemplate').html()),

    initialize:(@model) ->
      console.log "@options", @options
   
    events:
      "click .yes"          : "yes",
      "click .no"           : "no",
      "click .answer"       : "answer"
      "click .over-pc"      : "showAllText"
      "click .com-count"    : "showComments"
      "click .over-hide-pc" : "hideAllText"
      "click .sbm-comment"  : "addComment"

    yes:() -> 
      @sendYoN("yes")

    no:() -> 
      @sendYoN("no")

  
    addComment: () ->
      message = false
      data = {}
      data.name = $(".inp-name-com").val()
      data.text = $(".inp-rew", @el).val()
      data.date = new Date()
      data.user = gUser["_id"] if gUser
      message = "Введите имя" if !data.name
      message = "Введите тексит отзыва" if !data.text
      if message
        alert message
        return
      $.ajax
        type    : 'POST'
        data    : {data:data, id:@model['_id']}
        url     : "/comment/create/comment"
        success : (com) =>
          $(".add-com-cont",@el).hide()
          @model.comments.push(com)
          @renderComments()
          $(".answer", @el).text("Ответить")
#          $(".com-count").text("Комментарии (" + @model.comments.length + ")")
#          console.log "ok"
  
    showComments: () ->
      st = $(".coments-cont", @el).css("display")
      console.log "st", st
      if st is "none"
        $(".coments-cont", @el).fadeIn("slow")
        $(".com-count", @el).text("Скрыть комментарии")
      else
        $(".coments-cont", @el).fadeOut("slow")
        $(".com-count", @el).text("Комментарии (" + @model.comments.length + ")")




    answer: ->
      st = $(".add-com-cont", @el).css("display")
      if st is "none"
        $(".add-com-cont", @el).show()
        $(".coments-cont", @el).fadeIn("slow")
        $(".answer", @el).text("Скрыть форму ответа")
        $(".com-count", @el).text("Скрыть комментарии")
      else
        $(".add-com-cont", @el).fadeOut("slow")
        $(".answer", @el).text("Ответить")
#      $(".rewiew-title").text("Коментарий к отзыву пользователя " + @model.name)
#      $(".inp-rew").removeClass("inp-rew-ob")
#      $(".inp-rew").addClass("inp-com")
#      $(".inp-rew").attr("idRew", @model["_id"])
#      addCalssKeup()

    sendYoN: (key) ->
      logUser = $("#firstData").attr("user")
      logUser = JSON.parse(logUser) if logUser
      if logUser
        data = {key:key, id:@model['_id']}
      else
        colors_yon =  $.cookie "colors_yon"
        console.log "colors_yon", colors_yon
        if colors_yon
          colors_yon = JSON.parse(colors_yon)
          check = true
          colors_yon.forEach (d) =>
            check = false if d.toString() is @model['_id']
          return if !check
          colors_yon.push(@model['_id'])
          $.cookie "colors_yon", JSON.stringify(colors_yon),
            expires: 360
            path:'/'
          data = {key:key, id:@model['_id'], st:true}
        else
          obj = []
          obj.push(@model['_id'])
          $.cookie "colors_yon", JSON.stringify(obj),
            expires: 360
            path:'/'
          data = {key:key, id:@model['_id'], st:true}
      $.ajax
        type    : 'POST'
        data    : data
        url     : "/comment/yon"
        success : (com) =>
          $(".yes", @el).text("Да (" + com.yes + ")")
          $(".no", @el).text("Нет (" + com.no + ")")
      
    showAllText: ->
      $(".rewiew-pc", @el).css("height", "100%")
      $(".over-pc", @el).hide()
      $(".over-hide-pc", @el).show()

    hideAllText: ->
      $(".rewiew-pc", @el).css("height", "30")
      $(".over-pc", @el).show()
      $(".over-hide-pc", @el).hide()

    renderComments: ->
      $(".ap-coments-cont", @el).empty()
      if @model.text.length < 150
        $(".over-pc", @el).hide()
      if @model.user?.ava
        $(".you-photo", @el).attr("src", "/img/users/" + @model.user["_id"] + "/ava." + @model.user.ava)
      @model.comments.forEach (data) ->
        template = _.template(jQuery('#commentTemplate').html())
        dateCom = new Date(data.date)
        data.time  = dateCom.toLocaleTimeString()
        data.sDate = dateCom.toLocaleDateString()
        data.avaLink = "/img/add-bg.png"
        if data.user and data.ava
          data.avaLink = "/img/users/" + data.user + "/ava." + data.ava 
        el = $(template({data:data}))
        $(".ap-coments-cont", @el).prepend(el)
        if data.text.length < 125
          $($(el).find(".over-c")).hide()
      
    render: ->
      @model.ava = "/img/add-bg.png"
      @model.ava = "/img/users/" + @model.user["_id"] + "/ava." + @model.user.ava if @model.user?.ava
      
      dateCom = new Date(@model.date)
      @model.time  = dateCom.toLocaleTimeString()
      @model.sDate = dateCom.toLocaleDateString()
      $(@el).html(@template({data:@model}));
      @el


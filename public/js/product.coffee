$(document).ready () ->
  arrViwe = []
  cookieArr = []
#  $.cookie "colors_favorites", null
  cookies_fav =  $.cookie "colors_favorites"
  gUser = $("#firstData").attr("user")
  gUser = JSON.stringify(gUser) if gUser
  gProduct = $("#firstData").attr("product")
  gProduct = JSON.stringify(gProduct) if gProduct
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
    $(".inp-com").unbind("keyup")
    $(".inp-rew-ob").keyup (e) ->
      if e.which is 13
        message = false
        data = {}
        data.name = $(".inp-name").val()
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
            arrViwe.push pCommentView
        
        
    $(".inp-com").keyup (e) ->
      if e.which is 13
        message = false
        data = {}
        data.name = $(".inp-name").val()
        data.text = $(@).val()
        data.date = new Date()
        message = "Введите имя" if !data.name
        message = "Введите тексит отзыва" if !data.text
        if message
          alert message
          return
        idCom = $(@).attr("idRew")
        arrViwe.forEach (viwe) ->
          console.log "viwe", viwe.model["_id"]
          if viwe.model["_id"] is idCom
            viwe.setCom(data)
          
        
      
  addCalssKeup()
      
  class PCommentView extends Backbone.View

    tagName: 'div'

    className: 'rew-block'

    template: _.template($('#pCommentTemplate').html()),

    initialize:(@model) ->
      console.log "@options", @options
   
    events:
      "click .yes"      : "yes",
      "click .no"       : "no",
      "click .answer"   : "answer"

    yes:() -> 
      @sendYoN("yes")

    no:() -> 
      @sendYoN("no")

    setCom: (data) ->
      console.log "data", data
      $.ajax
        type    : 'POST'
        data    : {data:data, id:@model['_id']}
        url     : "/comment/create/comment"
        success : (com) =>
          @model.comments.push(com)
          $("#com-count").text("Комментарии (" + @model.comments.length + ")")
          console.log "ok"

    answer: ->
      $(".rewiew-title").text("Коментарий к отзыву пользователя " + @model.name)
      $(".inp-rew").removeClass("inp-rew-ob")
      $(".inp-rew").addClass("inp-com")
      $(".inp-rew").attr("idRew", @model["_id"])
      addCalssKeup()

    sendYoN: (key) ->
      logUser = $("#firstData").attr("user")
      logUser = JSON.parse(logUser) if logUser
      console.log "logUser", logUser
      if logUser
        $.ajax
          type    : 'POST'
          data    : {key:key, id:@model['_id']}
          url     : "/comment/yon"
          success : (com) =>
            $(".yes", @el).text("Да (" + com.yes + ")")
            $(".no", @el).text("Нет (" + com.no + ")")

    render: ->
      dateCom = new Date(@model.date)
      @model.time  = dateCom.toLocaleTimeString()
      @model.sDate = dateCom.toLocaleDateString()
      $(@el).html(@template({data:@model}));
      @el


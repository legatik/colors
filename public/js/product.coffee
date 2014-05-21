$(document).ready () ->
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
      
  getComments()

  if cookies_fav and cookies_fav != "null" and !userTest
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

  $(".inp-rew").keyup (e) ->
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
      
      

  class PCommentView extends Backbone.View

    tagName: 'div'

    className: 'rew-block'

    template: _.template($('#pCommentTemplate').html()),

    initialize:(@model) ->
      console.log "@options", @options
   
    events:
      "click .peview-dish"      : "render",

    render: ->
      dateCom = new Date(@model.date)
      @model.time  = dateCom.toLocaleTimeString()
      @model.sDate = dateCom.toLocaleDateString()
      $(@el).html(@template({data:@model}));
      @el


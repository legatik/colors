$(document).ready () ->
  cookieArr = []
#  $.cookie "colors_favorites", null
  cookies_fav =  $.cookie "colors_favorites"
  userTest = $("#firstData").attr("user")
  check = true

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


$(document).ready () ->
  testUser = $("#firstData").attr("user")
  console.log "testUser", testUser

  if !testUser
    cookies_cart =  $.cookie "colors_cart"
    if cookies_cart and cookies_cart != "null"
      cookieArr = JSON.parse(cookies_cart)
      $.ajax
        type    : 'POST'
        data    : {prodArr:cookieArr}
        url     : "/user/get/favorites"
        success : (arrProd) =>
          console.log "arrProd", arrProd
          arrProd.forEach (pr) -> 
            templateJQ = $("#productTemplate")
            template = _.template($(templateJQ[0]).html())
            $("#cont-cart").prepend(template({pr:pr}))
          onEvents()

  onEvents = () ->
    $(".cost-change-cart").unbind("keyup")
    $(".cost-change-cart").on "keyup", (e) ->
      id = ($(@).attr("id")).replace("ch", "")
      val = $(@).val()
      cost = Number($(@).attr("cost"))
      if val
        idres = "#res" + id
        sum = cost * Number(val) 
        $(idres).text(sum)
  onEvents()
    

$(document).ready () ->
  objProd = {}
  testUser = $("#firstData").attr("user")
  tempProdObj = JSON.parse($("#firstData").attr("products"))
  
  if tempProdObj.length
    tempProdObj.forEach (prod) ->
      objProd[prod["_id"]] = {
        sum  : Number(prod.cost)
        cost : Number(prod.cost)
        col  : 1
      }
    
  console.log "objProd",objProd

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
    $(".cost-change-cart").unbind("change")
    $(".cost-change-cart").on "change", (e) ->
      id = ($(@).attr("id")).replace("ch", "")
      val = $(@).val()
      cost = Number($(@).attr("cost"))
      if val
        objProd[id].col = val
        console.log "objProd[id]", objProd[id]
        renderAllCost()
    
    
  $(".del-prod-cart").click () ->
    idProd = $(@).attr("idProd")
    $.ajax
      type    : 'POST'
      data    : {idDel:idProd}
      url     : "/user/remove_cart"
      success : (products) =>
        console.log "idProd", idProd
        classDel = ".del" + idProd
        $(classDel).remove()
    
    
  renderAllCost = () ->
    totalCost = 0
    _.each objProd, (d, k) ->
      d.sum = d.cost * d.col
      idres = "#res" + k
      $(idres).text(d.sum)
      totalCost = totalCost + d.sum
      
    $("#total-cost").text(totalCost)
  renderAllCost()
    
  onEvents()
    
    

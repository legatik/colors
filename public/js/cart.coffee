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
        ps   : 0
      }
      objProd[prod["_id"]].ps = false if prod.oldCost
      
      
    
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
    
    
    
  $(".promocode-input").keyup () ->
    idP = $(@).attr("idP")
    return if objProd[idP].ps is false
    
    objProd[idP].ps = 0
    renderAllCost()
    val = $(@).val()
    col = val.length
    if col is 4
      $.ajax
        type    : 'POST'
        data    : {code:val}
        url     : "/user/check_voucher"
        success : (d) =>
          if d.st
            objProd[idP].ps = Number(d.v.ps)
            renderAllCost()
    
    
  $(".del-prod-cart").click () ->
    idProd = $(@).attr("idProd")
    $.ajax
      type    : 'POST'
      data    : {idDel:idProd}
      url     : "/user/remove_cart"
      success : (products) =>
        classDel = ".del" + idProd
        $(classDel).remove()
    
    
  renderAllCost = () ->
    totalCost = 0
    _.each objProd, (d, k) ->
      d.sum = d.cost * d.col
      psVoucher = (d.sum/100) * d.ps
      d.sum = d.sum - psVoucher
      idres = "#res" + k
      $(idres).text(d.sum)
      totalCost = totalCost + d.sum
      
    $("#total-cost").text(totalCost)
  renderAllCost()
    
  onEvents()
    
    

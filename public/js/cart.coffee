$(document).ready () ->
  objProd = {}
  testQTvoucherObj = {}
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
      
      
    

  if !testUser
    cookies_cart =  $.cookie "colors_cart"
    if cookies_cart and cookies_cart != "null"
      cookieArr = JSON.parse(cookies_cart)
      $.ajax
        type    : 'POST'
        data    : {prodArr:cookieArr}
        url     : "/user/get/favorites"
        success : (arrProd) =>
          arrProd.forEach (prod) -> 
            templateJQ = $("#productTemplate")
            template = _.template($(templateJQ[0]).html())
            $("#cont-cart").prepend(template({pr:prod}))
            objProd[prod["_id"]] = {
              sum  : Number(prod.cost)
              cost : Number(prod.cost)
              col  : 1
              ps   : 0
            }
            objProd[prod["_id"]].ps = false if prod.oldCost
          renderAllCost()
          onEvents()

  onEvents = () ->
    $(".cost-change-cart").unbind("change")
    $(".promocode-input").unbind("keyup")
    $(".del-cart-cookie").unbind("click")
    
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
      
      objProd[idP].ps     = 0
      objProd[idP].psName = ""
      $('.promocode-input').attr("disabled", false)
      $('.promocode-input').removeClass("voucher-disabled")
    
    
    
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
              objProd[idP].ps     = Number(d.v.ps)
              objProd[idP].psName = d.v.name
              checkQTvoucher()
              renderAllCost()
    
    $(".del-cart-cookie").click () ->
      idProd = $(@).attr("idProd")
      classDel = ".del" + idProd
      cookies_fav =  $.cookie "colors_cart"
      cookieArr = JSON.parse(cookies_fav)
      newArr = []
      cookieArr.forEach (item) ->
        newArr.push(item) if idProd.toString() != item.toString()
      $.cookie "colors_cart", JSON.stringify(newArr),
        expires: 7
      $(classDel).remove()
      delete objProd[idProd]
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
        delete objProd[idProd]
        renderAllCost()
    
  checkQTvoucher = () ->
    _.each testQTvoucherObj, (d, k) ->
      console.log "d.qt", d.qt
      if d.qt >= 2
        $(".promocode-input").attr("disabled", "disabled") 
        $(".promocode-input").addClass("voucher-disabled")
        d.idArr.forEach (id) ->
          $('.promocode-input[idP="' + id + '"]').attr("disabled", false)
          $('.promocode-input[idP="' + id + '"]').removeClass("voucher-disabled")
    
    
  renderAllCost = () ->
    testQTvoucherObj = {}
    totalCost = 0
    _.each objProd, (d, k) ->
      d.sum = d.cost * d.col
      psVoucher = (d.sum/100) * d.ps
      d.sum = d.sum - psVoucher
      idres = "#res" + k
      $(idres).text(d.sum)
      totalCost = totalCost + d.sum
      if d.psName
        if testQTvoucherObj[d.psName]
          tm = testQTvoucherObj[d.psName].qt
          tm = tm + 1
          testQTvoucherObj[d.psName].qt = tm
          testQTvoucherObj[d.psName].idArr.push(k)
        else
          testQTvoucherObj[d.psName] = {}
          testQTvoucherObj[d.psName].idArr = [k]
          testQTvoucherObj[d.psName].qt = 1
      checkQTvoucher()

    $("#total-cost").text(totalCost)
  renderAllCost()
    
  onEvents()
    
    

$(document).ready () ->
  testUser = $("#firstData").attr("user")
  
  $(".cost-change-cart").on "keyup", (e) ->
    id = ($(@).attr("id")).replace("ch", "")
    val = $(@).val()
    cost = Number($(@).attr("cost"))
    if val
      idres = "#res" + id
      sum = cost * Number(val) 
      console.log "sum", sum
      console.log "idres", idres
      $(idres).text(sum)
    
    

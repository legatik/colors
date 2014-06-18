$(document).ready () ->

  $("#add-voucher").click () ->
    $("#add-voucher-cont").show()
    $("#list-voucher-cont").hide()

  $("#voucher-list").click () ->
    $("#list-voucher-cont").show()
    $("#add-voucher-cont").hide()
    getVouchers()


  $("#add-voucher-btn").click () ->
    newVoch = {
      name   : $("#v-name").val()
      code   : $("#v-cod").val()
      active : $("#v-act").prop("checked")
    }
    $.ajax
      method:"post"
      url: "/tool/admin/create_voucher"
      data: newVoch
      success: (data) ->
        $("#v-name").val("")
        $("#v-cod").val("")
        $("#alert-add-voucher").fadeIn("slow")


  getVouchers = () ->
    $.ajax
      method:"post"
      url: "/tool/admin/get_vouchers"
      success: (vouchers) ->
        console.log "vouchers",vouchers
        $("#list-v-body").empty()
        vouchers.forEach (v) ->
            templateJQ = $("#voucherListTemplate")
            template = _.template($(templateJQ[0]).html())
            $("#list-v-body").prepend(template({v:v}))
        addEvent()
  
  addEvent = () ->
    $(".fn-act").unbind("click")
    $(".fn-del").unbind("click")
    
    $(".fn-del").click () ->
      if confirm("Точно?")
        id = ($(@).attr("idV"))
        data = {id : id}
        $.ajax
          method:"post"
          url: "/tool/admin/remove_voucher"
          data: data
          success: (data) =>
            $($($(@).parent()).parent()).remove()
    
    $(".fn-act").click () ->
      id = ($(@).attr("idV"))
      act = $(@).attr("active")
      data = {
        id     : id
        active : act
      }
      $.ajax
        method:"post"
        url: "/tool/admin/chanch_voucher_active"
        data: data
        success: (data) =>
          if act is "false"
            $(@).attr("active", "true") 
            $(@).text("Снять активность")
          else
            $(@).attr("active", "false") 
            $(@).text("Aктивировать")
      
  
#  addEventDel = () ->
#    $(".fn-del").click () ->
#      if confirm("Вы уверенны")
#        idDel = $(@).attr("id")
#        $.ajax
#          method:"post"
#          url: "/tool/admin/del_user"
#          data: {id: idDel}
#          success: (data) ->
#            id = "#cont-" + idDel
#            $(id).remove()
#  
#  users = $("#first-data").attr("users")
#  if users
#    users = JSON.parse(users)
#    console.log "users", users
#    users.forEach (user) ->
#        templateJQ = $("#userListTemplate")
#        template = _.template($(templateJQ[0]).html())
#        $("#list-br-body").prepend(template({user:user}))
#    addEventDel()

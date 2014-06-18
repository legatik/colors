$(document).ready () ->

  $("#add-voucher").click () ->
    $("#add-voucher-cont").show()



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

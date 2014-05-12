$(document).ready () ->

  addEventDel = () ->
    $(".fn-del").click () ->
      if confirm("Вы уверенны")
        idDel = $(@).attr("id")
        $.ajax
          method:"post"
          url: "/tool/admin/del_user"
          data: {id: idDel}
          success: (data) ->
            id = "#cont-" + idDel
            $(id).remove()
  
  users = $("#first-data").attr("users")
  if users
    users = JSON.parse(users)
    console.log "users", users
    users.forEach (user) ->
        templateJQ = $("#userListTemplate")
        template = _.template($(templateJQ[0]).html())
        $("#list-br-body").prepend(template({user:user}))
    addEventDel()

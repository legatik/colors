$(document).ready () ->

  $("#in-comments-search").autocomplete
    source: (request, response) ->
      $.ajax
        url: "/tool/admin/q_comments_by_com"
        data: {title: $("#in-comments-search").val()}
        success: (data) ->
          response $.map(data, (item) ->
            label : item.text
            title : item.text
          )
    minLength: 2

  $("#start-search-comments").click () ->
    text = $("#in-comments-search").val()
    findCom(text)


  findCom = (title) ->
    $.ajax
      type    : 'GET'
      data    : {title:title}
      url     : "/tool/admin/q_comments_by_com"
      success : (comms) ->
        renderComments(comms)


  renderComments = (comms) -> 
    $("#list-cm-body").empty()
    console.log "comms", comms
    comms.forEach (com) ->
        templateJQ = $("#commentsListTemplate")
        template = _.template($(templateJQ[0]).html())
        console.log "template", template 
        $("#list-cm-body").prepend(template({com:com}))
    addEventDel()

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

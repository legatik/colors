$(document).ready () ->
  $(".agree").click () ->
    obj = 
      name    :  $(".name").val()
      gender  : $(".gender").val()
      town    : $(".town").val()
      vk      : $(".vk").val()
      aboutme : $(".about-me").val()
    day = $(".day").val()
    month = $(".month").val()
    year = $(".year").val()
    dateNew = month + "/" + day + "/" + year
    console.log "dateNew", dateNew
    obj.birthday = new Date('01/01/2000')
    $.ajax
      method:"post"
      data: {data: obj}
      url: "/user/update"
      success: (data) ->
        console.log "END"
  fUser = JSON.parse( $("#firstData").attr("user"))
  $(".gender").val(fUser.gender)

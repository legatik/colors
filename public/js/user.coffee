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
    obj.birthday = new Date(dateNew)
    $.ajax
      method:"post"
      data: {data: obj}
      url: "/user/update"
      success: (data) ->
        window.location.reload()
  fUser = JSON.parse( $("#firstData").attr("user"))
  $(".gender").val(fUser.gender)
  dateB = new Date(fUser.birthday)
  dayB = dateB.getDate()
  monthB = (dateB.getMonth()) + 1
  yearB = dateB.getFullYear()
  
  console.log "1", dayB
  console.log "1", yearB
  console.log "1", monthB
  
  $(".day").val(dayB)
  $(".month").val(monthB)
  $(".year").val(yearB)

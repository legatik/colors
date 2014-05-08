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
    if month and day and year
      dateNew = month + "/" + day + "/" + year
      obj.birthday = new Date(dateNew)

    img  = ($("#load-photo-user"))[0].files[0]
    newForm = new FormData()
    newForm.append("data",JSON.stringify obj)
    newForm.append("ava", img)


    $.ajax
      method:"post"
      data: newForm
      url: "/user/update"
      cache: false
      contentType: false
      processData: false
      success: (data) ->
        window.location.reload()
    
  readURL = (input) ->
    if input.files and input.files[0]
      if input.files[0].type.indexOf("image") != -1
        reader = new FileReader()
        reader.readAsDataURL input.files[0]
        reader.onload = (e) =>
          $("#img-prev-user").show()
          $("#img-prev-user").attr "src", e.target.result
          $("#load-photo-user").hide()
          $(".del-img-u").text("Удалить")
      else
        alert("Такой фармат картинки не поддерживается")
    
        
  $("#load-photo-user").change () ->
    readURL(@)

  $(".del-img-u").click () ->
    $("#img-prev-user").attr "src", "#"
    $("#img-prev-user").hide()
    $("#load-photo-user").val('')
    $("#load-photo-user").show()
    $(".del-img-u").text("Загрузить")

        
  fUser = JSON.parse( $("#firstData").attr("user"))
  $(".gender").val(fUser.gender)
  dateB = new Date(fUser.birthday)
  dayB = dateB.getDate()
  monthB = (dateB.getMonth()) + 1
  yearB = dateB.getFullYear()
  $(".day").val(dayB)
  $(".month").val(monthB)
  $(".year").val(yearB)
  
  if fUser.ava
    $("#img-prev-user").show()
    $("#img-prev-user").attr "src", "/img/users/" + fUser["_id"] + "/" + "ava." + fUser.ava
    $("#load-photo-user").hide()
    $(".del-img-u").text("Удалить")




$(document).ready () ->
#  $.ajax
#    type    : 'GET'
#    url     : "/tool/admin/q_brend"
#    success : (brendArr) ->

  $("#brend-show").click (e) ->
    $("#brend-form").show()

  $("#img-breng").change () ->
    readURLImg(@)
         
  $("#logo-breng").change () ->
    readURlLogo(@)
          
          
  $("#img-prev-close").click () ->
    $("#img-breng").val('')
    $("#prev-brend").attr "src", "/img/add-bg.png"
    $("#img-prev-close").hide()
          

  $("#logo-prev-close").click () ->
    $("#logo-breng").val('')
    $("#logo-img-breng").attr "src", "/img/add-bg.png"
    $("#logo-prev-close").hide()
          
  readURlLogo = (input) =>
    if input.files and input.files[0]
      if input.files[0].type.indexOf("image") != -1
        reader = new FileReader()
        reader.readAsDataURL input.files[0]
        reader.onload = (e) =>
          $("#logo-img-breng").attr "src", e.target.result
          $("#logo-prev-close").show()
      else
        alert("Такой фармат картинки не поддерживается")
          
  readURLImg = (input) =>
    if input.files and input.files[0]
      if input.files[0].type.indexOf("image") != -1
        reader = new FileReader()
        reader.readAsDataURL input.files[0]
        reader.onload = (e) =>
          $("#prev-brend").attr "src", e.target.result
          $("#img-prev-close").show()
      else
        alert("Такой фармат картинки не поддерживается")


  cleanData = () ->
    $("#brend-name").val("")
    $("#brend-name").val("")
    $("#brend-desc").val("")
    $("#img-breng").val('')
    $("#prev-brend").attr "src", "/img/add-bg.png"
    $("#img-prev-close").hide()
    $("#logo-breng").val('')
    $("#logo-img-breng").attr "src", "/img/add-bg.png"
    $("#logo-prev-close").hide()


  $("#add-brend").click (e) ->
    brendName = $("#brend-name").val()
    desc = $("#brend-desc").val()
    active = $("#active").is(':checked')
#    return if !brendName or !desc
    objSend = {
        title   : brendName
        description : desc
        active      : active
    }
    img  = ($("#img-breng"))[0].files[0]
    logo = ($("#logo-breng"))[0].files[0]
    
    newForm = new FormData()
    newForm.append("data",JSON.stringify objSend)
    newForm.append("img", img)
    newForm.append("logo", logo)
    
    
    $.ajax
      type    : 'POST'
      data    : newForm
      url     : "/create/brend"
      cache: false
      contentType: false
      processData: false
      success : (brend) ->
        cleanData()
        $("#success-brend").hide()
        $("#success-brend").fadeIn("slow")
        

  
        

$(document).ready () ->
#  $.ajax
#    type    : 'GET'
#    url     : "/tool/admin/q_brend"
#    success : (brendArr) ->

  $("#brend-show").click (e) ->
    $("#brend-form").show()

  $("#add-brend").click (e) ->
    brendName = $("#brend-name").val()
    return if !brendName
    objSend = {brendName:brendName}
    $.ajax
      type    : 'GET'
      data    : objSend
      url     : "/tool/admin/create_brend"
      success : (brend) ->
        $("#brend-name").val("")
        $("#success-brend").hide()
        $("#success-brend").fadeIn("slow")
        
          
          
          
  $("#img-breng").change () ->
    readURLImg(@)
          
          
          
  $("#img-prev-close").click () ->
    $("#img-breng").val('')
    $("#prev-brend").attr "src", "/img/add-bg.png"
    $("#img-prev-close").hide()
          
          
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
        

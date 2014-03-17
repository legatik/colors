$(document).ready () ->
#  $.ajax
#    type    : 'GET'
#    url     : "/tool/admin/q_brend"
#    success : (brendArr) ->

  $("#brend-show").click (e) ->
    $(".form-admin").hide()
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
    
          
        

$(document).ready () ->


  $("#v-inp-im").change (e) ->
    readURILog this

  $("#v-inp-s").change (e) ->
    readURILogS this
    
  $("#v-cl-im").click (e) ->
    $("#v-inbg-im").attr("src", "/img/add-bg.png")
    $("#v-inp-im").val("")
    $("#v-cl-im").hide()
 
  $("#v-cl-s").click (e) ->
    $("#v-inbg-s").attr("src", "/img/add-bg.png")
    $("#v-inp-s").val("")
    $("#v-cl-s").hide() 
    
  readURILog = (input) ->
    if input.files and input.files[0]
      if input.files[0].type.indexOf("image") != -1
        reader = new FileReader()
        reader.readAsDataURL input.files[0]
        reader.onload = (e) =>
          $("#v-inbg-im").attr "src", e.target.result
          $("#v-cl-im").show()
      else
        alert("Не верный формат картинки")

  readURILogS = (input) ->
    if input.files and input.files[0]
      if input.files[0].type.indexOf("image") != -1
        reader = new FileReader()
        reader.readAsDataURL input.files[0]
        reader.onload = (e) =>
          $("#v-inbg-s").attr "src", e.target.result
          $("#v-cl-s").show()
      else
        alert("Не верный формат картинки")

    
      
  cleanData = () ->
    $("#v-inbg-im").attr("src", "/img/add-bg.png")
    $("#v-inp-im").val("")
    $("#v-cl-im").hide()
    
    $("#v-inbg-s").attr("src", "/img/add-bg.png")
    $("#v-inp-s").val("")
    $("#v-cl-s").hide()
    
    $("#title-news").val("")
    $("#dec").val("")

  $("#add-new").click (e) ->
    vetrina = $("#vetrina").is(':checked')
    title = $("#title-news").val()
    desc = $("#dec").val()

    objSend = {
        descriptions  : desc
        vetrina       : vetrina
        title         : title
    }

    logo = ($("#v-inp-im"))[0].files[0]
    images = ($("#v-inp-s"))[0].files[0]
    
    newForm = new FormData()
    newForm.append("data",JSON.stringify objSend)
    newForm.append("logo", logo)
    newForm.append("images", images)

    $.ajax
      type    : 'POST'
      data    : newForm
      url     : "/create/news"
      cache: false
      contentType: false
      processData: false
      success : (st) ->
        cleanData()
        $("#success-new").hide()
        $("#success-new").fadeIn("slow")


$(document).ready () ->

  renderImg = () ->
    if news.images
      img = "/img/news/" + news["_id"] + "/img." + news["img"]
      console.log "img", img
      $("#v-inbg-s").attr("src",img)
      $("#img-prev-fs-del").show()
    if news.logo
      img = "/img/news/" + news["_id"] + "/logo." + news["logo"]
      $("#v-inbg-im").attr("src",img)
      $("#logo-prev-fs-del").show()
  


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

  delImgF = (cb) ->
    if !delImg
      cb()
    else
      $.ajax
        type    : 'POST'
        data    : {brend : brend["_id"], key:"images"}
        url     : "/tool/admin/edit/new/del/file"
        success : (brend) ->
          cb()

  delLogoF = (cb) ->
    if !delLogo
      cb()
    else
      $.ajax
        type    : 'POST'
        data    : {brend : brend["_id"], key:"logo"}
        url     : "/tool/admin/edit/new/del/file"
        success : (brend) ->
          cb()


  $("#add-new").click (e) ->
    delImgF () ->
      delLogoF () ->
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
            window.location.reload()


  $("#logo-prev-fs-del").click (e) ->
    delLogo = true
    $("#logo-prev-fs-del").hide()
    $("#v-inbg-im").attr("src", "/img/add-bg.png")
        
  $("#img-prev-fs-del").click (e) ->
    delImg = true
    $("#img-prev-fs-del").hide()
    $("#v-inbg-s").attr("src", "/img/add-bg.png")





  delImg  = false
  delLogo = false
  news = JSON.parse($("#firstData").attr("news"))
  
  
  renderImg()


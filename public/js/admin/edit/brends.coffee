$(document).ready () ->

  renderImg = () ->
    if brend.img
      img = "/img/brends/" + brend["_id"] + "/img." + brend["img"]
      $("#prev-brend").attr("src",img)
      $("#img-prev-fs-del").show()
    if brend.logo
      img = "/img/brends/" + brend["_id"] + "/logo." + brend["logo"]
      $("#logo-img-breng").attr("src",img)
      $("#logo-prev-fs-del").show()
  
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


  $("#addDescStep").click () ->
    $("#brendDescCont").append("<textarea class='textarea-add-m3 brend-desc add-step'/>")
          
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
    $(".add-step").remove()
    $(".brend-desc").val('')
    
  $("#add-brend").click (e) ->
    delImgF () ->
      delLogoF () ->
        brendName = $("#brend-name").val()
        desc = []
        
        arrDesc = $(".brend-desc")
        arrDesc.each (i, el) ->
          val = $(el).val()
          desc.push(val) if val

        active = $("#active").is(':checked')
        objSend = {
          id          : brend["_id"]
          title       : brendName
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
          url     : "/edit/new"
          cache: false
          contentType: false
          processData: false
          success : (brend) ->
            window.location.reload()
        

  $("#logo-prev-fs-del").click (e) ->
    delLogo = true
    $("#logo-prev-fs-del").hide()
    $("#logo-img-breng").attr("src", "/img/add-bg.png")
        
  $("#img-prev-fs-del").click (e) ->
    delImg = true
    $("#img-prev-fs-del").hide()
    $("#prev-brend").attr("src", "/img/add-bg.png")

  delImgF = (cb) ->
    if !delImg
      cb()
    else
      $.ajax
        type    : 'POST'
        data    : {brend : brend["_id"], key:"img"}
        url     : "/tool/admin/edit/brend/del/file"
        success : (brend) ->
          cb()

  delLogoF = (cb) ->
    if !delLogo
      cb()
    else
      $.ajax
        type    : 'POST'
        data    : {brend : brend["_id"], key:"logo"}
        url     : "/tool/admin/edit/brend/del/file"
        success : (brend) ->
          cb()

  delImg  = false
  delLogo = false
  brend = JSON.parse($("#firstData").attr("brend"))

  renderImg()


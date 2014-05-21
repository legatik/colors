$(document).ready () ->


  delImg  = false
  delLogo = false
  delPoster = false
  arrProductAct = []

  renderImg = () ->
    if action.img
      img = "/img/actions/" + action["_id"] + "/img." + action["img"]
      $("#prev-brend").attr("src",img)
      $("#img-prev-fs-del").show()
    if action.logo
      img = "/img/actions/" + action["_id"] + "/logo." + action["logo"]
      $("#logo-img-breng").attr("src",img)
      $("#logo-prev-fs-del").show()
    
    if action.poster
      img = "/img/actions/" + action["_id"] + "/poster." + action["poster"]
      $("#poster-img-breng").attr("src",img)
      $("#poster-prev-fs-del").show()
    
    action.products.forEach (pr) ->
      arrProductAct.push(pr["_id"])


  $("#img-breng").change () ->
    readURLImg(@)
         
  $("#logo-breng").change () ->
    readURlLogo(@)
       
  $("#poster-breng").change () ->
    readURlPoster(@)   
          
  $("#img-prev-close").click () ->
    $("#img-breng").val('')
    $("#prev-brend").attr "src", "/img/add-bg.png"
    $("#img-prev-close").hide()
          

  $("#logo-prev-close").click () ->
    $("#logo-breng").val('')
    $("#logo-img-breng").attr "src", "/img/add-bg.png"
    $("#logo-prev-close").hide()

  $("#poster-prev-close").click () ->
    $("#poster-breng").val('')
    $("#poster-img-breng").attr "src", "/img/add-bg.png"
    $("#poster-prev-close").hide()
          
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

  readURlPoster = (input) =>
    if input.files and input.files[0]
      if input.files[0].type.indexOf("image") != -1
        reader = new FileReader()
        reader.readAsDataURL input.files[0]
        reader.onload = (e) =>
          $("#poster-img-breng").attr "src", e.target.result
          $("#poster-prev-close").show()
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
    $("#poster-breng").val('')
    $("#poster-img-breng").attr "src", "/img/add-bg.png"
    $("#poster-prev-close").hide()
    $("#prod-ac-cont > div").remove()
    arrProductAct = []


  $("#in-ac-product").autocomplete
    source: (request, response) ->
      $.ajax
        url: "/tool/admin/q_prod_by_name"
        data: {title: $("#in-ac-product").val()}
        success: (data) ->
          response $.map(data, (item) ->
            label : item.title
            value : item["_id"]
          )
    select: (event, ui) =>
      id = ui.item.value
      title = ui.item.label
      check = true
      arrProductAct.forEach (item)->
        check = false if item == id
      if check
        arrProductAct.push(id)
        templateJQ = $("#productTemplate")
        template = _.template($(templateJQ[0]).html())
        $("#prod-ac-cont").append(template({id:id,title:title}))
        addEventDel()
      else
        alert("Такой продукт уже имеется в списке")
    close: (event, ui) =>
      $("#in-ac-product").val("")
    minLength: 2

  addEventDel = () ->
    $(".ac-del-prod").unbind("click")
    $(".ac-del-prod").click () ->
      id = $(@).attr("id")
      arrProductAct = _.without arrProductAct, id 
      $($(@).parent()).remove()
      
  $("#add-brend").click (e) ->
    delImgF () ->
      delLogoF () ->
        delLogoP () ->
          brendName = $("#brend-name").val()
          desc = $("#brend-desc").val()
          active = $("#active").is(':checked')
          objSend = {
            id          : action["_id"]
            title       : brendName
            description : desc
            active      : active
            products    : arrProductAct
          }
          img  = ($("#img-breng"))[0].files[0]
          logo = ($("#logo-breng"))[0].files[0]
          poster = ($("#poster-breng"))[0].files[0]
          
          newForm = new FormData()
          newForm.append("data",JSON.stringify objSend)
          newForm.append("img", img)
          newForm.append("logo", logo)
          newForm.append("poster", poster)
          
          $.ajax
            type    : 'POST'
            data    : newForm
            url     : "/edit/action"
            cache: false
            contentType: false
            processData: false
            success : (brend) ->
              window.location.reload()


  delImgF = (cb) ->
    if !delImg
      cb()
    else
      $.ajax
        type    : 'POST'
        data    : {brend : action["_id"], key:"img"}
        url     : "/tool/admin/edit/action/del/file"
        success : () ->
          cb()

  delLogoF = (cb) ->
    if !delLogo
      cb()
    else
      $.ajax
        type    : 'POST'
        data    : {brend : action["_id"], key:"logo"}
        url     : "/tool/admin/edit/action/del/file"
        success : () ->
          cb()

  delLogoP = (cb) ->
    if !delPoster
      cb()
    else
      $.ajax
        type    : 'POST'
        data    : {brend : action["_id"], key:"poster"}
        url     : "/tool/admin/edit/action/del/file"
        success : () ->
          cb()


  $("#logo-prev-fs-del").click (e) ->
    delLogo = true
    $("#logo-prev-fs-del").hide()
    $("#logo-img-breng").attr("src", "/img/add-bg.png")

  $("#poster-prev-fs-del").click (e) ->
    delPoster = true
    $("#poster-prev-fs-del").hide()
    $("#poster-img-breng").attr("src", "/img/add-bg.png")
        
  $("#img-prev-fs-del").click (e) ->
    delImg = true
    $("#img-prev-fs-del").hide()
    $("#prev-brend").attr("src", "/img/add-bg.png")


  action = JSON.parse($("#firstData").attr("action"))
  
  
  renderImg()
  addEventDel()
  
          

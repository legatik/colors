$(document).ready () ->

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


  arrProductAct = []
  $("#in-ac-product").autocomplete
    source: (request, response) ->
      $.ajax
        url: "/tool/admin/q_prod_by_name"
        data: {title: $("#in-ac-product").val()}
        success: (data) ->
          console.log "sds", data
          response $.map(data, (item) ->
            label : item.title
            value : item["_id"]
          )
    select: (event, ui) =>
      id = ui.item.value
      title = ui.item.label
      arrProductAct.push(id)
      templateJQ = $("#productTemplate")
      template = _.template($(templateJQ[0]).html())
      $("#prod-ac-cont").append(template({id:id,title:title}))
      addEventDel()
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
    brendName = $("#brend-name").val()
    desc = $("#brend-desc").val()
    active = $("#active").is(':checked')
    objSend = {
        title       : brendName
        description : desc
        active      : active
        products    : arrProductAct
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
      url     : "/create/action"
      cache: false
      contentType: false
      processData: false
      success : (brend) ->
        cleanData()
        $("#success-brend").hide()
        $("#success-brend").fadeIn("slow")
        

  
        

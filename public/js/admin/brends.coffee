$(document).ready () ->
#  $.ajax
#    type    : 'GET'
#    url     : "/tool/admin/q_brend"
#    success : (brendArr) ->

  $("#brend-show").click (e) ->
    $(".form-admin").hide()
    $("#brend-form").show()

  $("#brend-list").click (e) ->
    $(".form-admin").hide()
    $("#brend-list-form").show()


# --------------------------- Для добовления бренда

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
        

# ------------------------- Для списка бредо

  




  $("#start-search-brends ").click () ->
    title = $("#in-brend-search").val()
    findBrends(title)

  $("#in-brend-search").autocomplete
    source: (request, response) ->
      $.ajax
        url: "/tool/admin/q_brend_by_name"
        data: {title: $("#in-brend-search").val()}
        success: (data) ->
          response $.map(data, (item) ->
            label : item.title
            title : item.title
          )
    minLength: 2


  renderBrends = (brends) ->
    brends.forEach (brend) ->
        templateJQ = $("#brendListTemplate")
        template = _.template($(templateJQ[0]).html())
        $("#list-br-body").append(template({brend:brend}))
    addEventList()

  findBrends = (title) ->
    $.ajax
      type    : 'GET'
      data    : {title:title}
      url     : "/tool/admin/q_brend_by_name"
      success : (brends) ->
        renderBrends(brends)
  
  addEventList = () ->
    $(".fn-act").unbind("click")
    $(".fn-act").click (e) ->
      if confirm("Вы уверенны?")
        id = ($(@).attr("id")).replace("act-", "")
        act = $(@).attr("active")
        data = {
          id     : id
          active : act
        }
        console.log "data", data
        $.ajax
          type: "POST"
          url: "/tool/admin/fn_act_brend"
          data: data
          success: (data) =>
            if act is "false"
              $(@).attr("active", "true") 
              $(@).text("Снять активность")
              $($($($(@).parent()).parent()).find(".br-st-act")).text("true")
            else
              $(@).attr("active", "false") 
              $(@).text("Aктивировать")
              $($($($(@).parent()).parent()).find(".br-st-act")).text("false")
        
        
        
        
        

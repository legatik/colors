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
    brendName = $("#brend-name").val()
    desc = []
    
    arrDesc = $(".brend-desc")
    arrDesc.each (i, el) ->
      val = $(el).val()
      desc.push(val) if val

    active = $("#active").is(':checked')
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
    $("#list-br-body").empty()
    brends.forEach (brend) ->
        templateJQ = $("#brendListTemplate")
        template = _.template($(templateJQ[0]).html())
        $("#list-br-body").prepend(template({brend:brend}))
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
    $(".fn-del").unbind("click")
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
    
    $(".fn-del").click () ->
      if confirm("Вы уверенны?")
#        if confirm("Вы точно уверенны? Последствия не обратимы!")
        id = ($(@).attr("id")).replace("del-", "")
        $.ajax
          type: "POST"
          url: "/tool/admin/del_brend"
          data: {id:id}
          success: (data) =>
            $($($(@).parent()).parent()).remove()

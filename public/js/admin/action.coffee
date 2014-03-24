$(document).ready () ->

  $("#brend-show").click (e) ->
    $("#brend-form").show()
    $(".form-admin").hide()

  $("#actin-list").click (e) ->
    $(".form-admin").hide()
    $("#action-list-form").show()


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

  arrProductAct = []
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
        
# Для списка


  $("#start-search-action ").click () ->
    title = $("#in-action-search").val()
    findAction(title)

  $("#in-action-search").autocomplete
    source: (request, response) ->
      $.ajax
        url: "/tool/admin/q_action_by_name"
        data: {title: $("#in-action-search").val()}
        success: (data) ->
          response $.map(data, (item) ->
            label : item.title
            title : item.title
          )
    minLength: 2


  renderAction = (actions) ->
    $("#list-ac-body").empty()
    actions.forEach (action) ->
        templateJQ = $("#actListTemplate")
        template = _.template($(templateJQ[0]).html())
        $("#list-ac-body").prepend(template({act:action}))
    addEventList()

  findAction = (title) ->
    $.ajax
      type    : 'GET'
      data    : {title:title}
      url     : "/tool/admin/q_action_by_name"
      success : (actions) ->
        renderAction(actions)
  
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
        $.ajax
          type: "POST"
          url: "/tool/admin/fn_act_action"
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
        if confirm("Вы точно уверенны? Последствия не обратимы!")
          id = ($(@).attr("id")).replace("del-", "")
          $.ajax
            type: "POST"
            url: "/tool/admin/del_action"
            data: {id:id}
            success: (data) =>
              $($($(@).parent()).parent()).remove()

  
        

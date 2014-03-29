$(document).ready () ->
  gDescI  = 1
  gImageI = 1
  
  $("#new-show").click (e) ->
    $(".form-admin").hide()
    $("#new-form").show()
    
  $("#new-list-btn").click (e) ->
    $(".form-admin").hide()
    $("#new-list-form").show()
    
#  $("#add-step-img").click (e) ->
#    templateJQ = $("#stepImg")
#    template = _.template($(templateJQ[0]).html())
#    $("#table-img").append(template({i:gImageI}))
#    gImageI++
#    addEvent()


#  $("#add-step-txt").click (e) ->
#    templateJQ = $("#stepDesc")
#    template = _.template($(templateJQ[0]).html())
#    $("#table-desc").append(template({i:gDescI}))
#    gDescI++


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

    
#  addEvent = () ->
#    $(".small-inp-cks").unbind("change")
#    $(".small-del-cks").unbind("click")
#    $(".small-inp-cks").change (e) ->
#      id = $(@).attr("id")
#      idImg = "#" + id.replace("inp","inbg")
#      readURLStep this,idImg

#    $(".small-del-cks").click (e) ->
#      first = $(@).attr("first")
#      if first
#        $("#st-inbg-im-0").attr("src", "/img/add-bg.png")
#        $("#st-inp-im-0").val("")
#        $("#st-cl-im-0").hide()
#      else
#        id = $(@).attr("id")
#        trId = "#" + id.replace("cl","tr")
#        console.log "trId",trId
#        $(trId).remove()
        
#  readURLStep = (input,idImg) =>
#    if input.files and input.files[0]
#      if input.files[0].type.indexOf("image") != -1
#        reader = new FileReader()
#        reader.readAsDataURL input.files[0]
#        reader.onload = (e) =>
#          $(idImg).attr "src", e.target.result
#          idDel = idImg.replace("inbg","cl")
#          $(idDel).show()
#      else
#        alert("Не верный формат картинки")
#  addEvent()
      
  cleanData = () ->
#    trDescArr = $("#table-desc").find("tr")
#    trDescArr.each (i, el) ->
#      first = $(el).attr("first")
#      if first
#        $($(el).find("textarea")).val("")
#      else
#        $(el).remove()

#    trImdArr = $("#table-img").find("tr")
#      
#    trImdArr.each (i, el) ->
#      first = $(el).attr("first")
#      if first
#        $("#st-inbg-im-0").attr("src", "/img/add-bg.png")
#        $("#st-inp-im-0").val("")
#        $("#st-cl-im-0").hide()
#      else
#        $(el).remove()
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
#    descArr = []
#    trDescArr = $("#table-desc").find("tr")
#    trDescArr.each (i, el) ->
#      val = $($(el).find("textarea")).val()
#      descArr.push(val) if val

#    imgArr = $("#table-img").find("input[type='file']")

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

#    imgArr.each (index, el) ->
#      console.log "index",index
#      file = ($(el))[0].files[0]
#      newForm.append(index, file)

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




        
# Для списка


  $("#start-search-new").click () ->
    title = $("#in-new-search").val()
    findNews(title)

  $("#in-new-search").autocomplete
    source: (request, response) ->
      $.ajax
        url: "/tool/admin/q_new_by_name"
        data: {title: $("#in-action-search").val()}
        success: (data) ->
          response $.map(data, (item) ->
            label : item.title
            title : item.title
          )
    minLength: 2


  renderNews = (news) ->
    $("#list-new-body").empty()
    news.forEach (newOne) ->
        templateJQ = $("#newListTemplate")
        template = _.template($(templateJQ[0]).html())
        $("#list-new-body").prepend(template({news:newOne}))
    addEventList()

  findNews = (title) ->
    $.ajax
      type    : 'GET'
      data    : {title:title}
      url     : "/tool/admin/q_new_by_name"
      success : (actions) ->
        renderNews(actions)
  
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
          url: "/tool/admin/fn_new_action"
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
            url: "/tool/admin/del_news"
            data: {id:id}
            success: (data) =>
              $($($(@).parent()).parent()).remove()

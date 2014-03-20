$(document).ready () ->
  gDescI  = 1
  gImageI = 1

  $("#new-show").click (e) ->
    $("#new-form").show()


  $("#add-step-img").click (e) ->
    templateJQ = $("#stepImg")
    template = _.template($(templateJQ[0]).html())
    $("#table-img").append(template({i:gImageI}))
    gImageI++
    addEvent()


  $("#add-step-txt").click (e) ->
    templateJQ = $("#stepDesc")
    template = _.template($(templateJQ[0]).html())
    $("#table-desc").append(template({i:gDescI}))
    gDescI++


  $("#v-inp-im").change (e) ->
    readURILog this
    
  $("#v-cl-im").click (e) ->
    $("#v-inbg-im").attr("src", "/img/add-bg.png")
    $("#v-inp-im").val("")
    $("#v-cl-im").hide()
  
    
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
    
  addEvent = () ->
    $(".small-inp-cks").unbind("change")
    $(".small-del-cks").unbind("click")
    $(".small-inp-cks").change (e) ->
      id = $(@).attr("id")
      idImg = "#" + id.replace("inp","inbg")
      readURLStep this,idImg

    $(".small-del-cks").click (e) ->
      first = $(@).attr("first")
      if first
        $("#st-inbg-im-0").attr("src", "/img/add-bg.png")
        $("#st-inp-im-0").val("")
        $("#st-cl-im-0").hide()
      else
        id = $(@).attr("id")
        trId = "#" + id.replace("cl","tr")
        console.log "trId",trId
        $(trId).remove()
        
  readURLStep = (input,idImg) =>
    if input.files and input.files[0]
      if input.files[0].type.indexOf("image") != -1
        reader = new FileReader()
        reader.readAsDataURL input.files[0]
        reader.onload = (e) =>
          $(idImg).attr "src", e.target.result
          idDel = idImg.replace("inbg","cl")
          $(idDel).show()
      else
        alert("Не верный формат картинки")
  addEvent()
      
  cleanData = () ->
    trDescArr = $("#table-desc").find("tr")
    trDescArr.each (i, el) ->
      first = $(el).attr("first")
      if first
        $($(el).find("textarea")).val("")
      else
        $(el).remove()

    trImdArr = $("#table-img").find("tr")
      
    trImdArr.each (i, el) ->
      first = $(el).attr("first")
      if first
        $("#st-inbg-im-0").attr("src", "/img/add-bg.png")
        $("#st-inp-im-0").val("")
        $("#st-cl-im-0").hide()
      else
        $(el).remove()
    $("#v-inbg-im").attr("src", "/img/add-bg.png")
    $("#v-inp-im").val("")
    $("#v-cl-im").hide()


  $("#add-new").click (e) ->
    vetrina = $("#vetrina").is(':checked')
    
    
    descArr = []
    trDescArr = $("#table-desc").find("tr")
    trDescArr.each (i, el) ->
      val = $($(el).find("textarea")).val()
      descArr.push(val) if val

    imgArr = $("#table-img").find("input[type='file']")

    objSend = {
        descriptions  : descArr
        vetrina       : vetrina
    }

    logo = ($("#v-inp-im"))[0].files[0]
    
    newForm = new FormData()
    newForm.append("data",JSON.stringify objSend)
    newForm.append("logo", logo)

    imgArr.each (index, el) ->
      console.log "index",index
      file = ($(el))[0].files[0]
      newForm.append(index, file)

    console.log  "newForm", newForm
    
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


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
    


#  cleanData = () ->
#    $("#brend-name").val("")
#    $("#brend-name").val("")
#    $("#brend-desc").val("")
#    $("#img-breng").val('')
#    $("#prev-brend").attr "src", "/img/add-bg.png"
#    $("#img-prev-close").hide()
#    $("#logo-breng").val('')
#    $("#logo-img-breng").attr "src", "/img/add-bg.png"
#    $("#logo-prev-close").hide()


  $("#add-new").click (e) ->
    alert(0)
#    brendName = $("#brend-name").val()
#    desc = $("#brend-desc").val()
#    active = $("#active").is(':checked')
##    return if !brendName or !desc
#    objSend = {
#        title   : brendName
#        description : desc
#        active      : active
#    }
#    img  = ($("#img-breng"))[0].files[0]
#    logo = ($("#logo-breng"))[0].files[0]
#    
#    newForm = new FormData()
#    newForm.append("data",JSON.stringify objSend)
#    newForm.append("img", img)
#    newForm.append("logo", logo)
#    
#    
#    $.ajax
#      type    : 'POST'
#      data    : newForm
#      url     : "/create/brend"
#      cache: false
#      contentType: false
#      processData: false
#      success : (brend) ->
#        cleanData()
#        $("#success-brend").hide()
#        $("#success-brend").fadeIn("slow")
#        

#  
#        

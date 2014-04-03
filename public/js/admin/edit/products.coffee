$(document).ready () ->
  withoutImg = []
  $.ajax
    type    : 'GET'
    url     : "/tool/admin/q_brend"
    success : (brendArr) ->


      renderType = () ->
        checkType = $("#gl-product-tip").val()
        $(".add-param").remove()
        idTemplate = "#" + checkType + "Template"
        templateJQ = $(idTemplate)
        template = _.template($(templateJQ[0]).html())
        $("#add-dish-table").append(template())
        addEventOnProductTip()

      selectFirstDate = () ->
        $("#product-tip").val(typeProd.data.type)
        $("option[value='" + typeProd.data.type + "']").click()
        opPerent = $("option[value='" + typeProd.data.podType + "']").parent()
        $(opPerent).val(typeProd.data.podType)
        switch typeProd.type
          when "face"
            typeProd.data.kozha.forEach (key) ->
              $("input[value='" + key + "']").attr("checked", true)
            typeProd.data.nesovershenstva.forEach (key) ->
              $("input[value='" + key + "']").attr("checked", true)
          when "body"
            typeProd.data.nesovershenstva.forEach (key) ->
              $("input[value='" + key + "']").attr("checked", true)
        

      $("#gl-product-tip").click () ->
        renderType()

      $("#brend-show").click (e) ->
        $(".form-admin").hide()
        $("#brend-form").show()

      $("#product-list").click (e) ->
        $(".form-admin").hide()
        $("#product-list-form").show()


      $("#add-product-btn").click () ->
        vidString = $("#prod-vid").val()
        vidArr = vidString.split(",")
        vidArr = [] if vidArr.length is 1 and vidArr[0] is ""
        productObj =
          withoutImg       : withoutImg
          findId           : prod["_id"]
          title            : $("#brend-title").val()
          minOpisanie      : $("#brend-min-disc").val()
          obem             : $("#brend-obem").val()
          ves              : $("#brend-ves").val()
          id               : $("#brend-id").val()
          oldCost          : $("#brend-old-cost").val()
          cost             : $("#brend-cost").val()
          opisanie         : $("#brend-desc").val()
          primenenie       : $("#brend-prim").val()
          vetrina          : $("#vetrina").is(':checked')
          ostatok          : $("#ostatok").val()
          vid              : vidArr
          imgVid           : ''
          brend            : $("#brend-select").val()
          picture          : []
          dateAdding       : new Date()
          popular          : 0
        imgArr = []

        vidImg = ($("#pic-tone"))[0].files[0]
        $(".step-inp").each (index, one) ->
          if one.files.length != 0
            imgArr.push one.files[0]

        checkType = $("#gl-product-tip").val()

        switch checkType
          when "face"
              editProdFace(productObj, imgArr, vidImg)
        switch checkType
          when "body"
              editProdBody(productObj, imgArr, vidImg)


      addEventOnProductTip = () ->
          $(".activePodType").removeClass("activePodType")
          idPodTip = "#" + $("#product-tip").val()
          $(idPodTip).show()
          $(idPodTip).addClass("activePodType")
          $("#product-tip").click (e) ->
            $(".activePodType").removeClass("activePodType")
            $(".podtip").hide()
            idPodTip = "#" + $(@).val()
            $(idPodTip).addClass("activePodType")
            $(idPodTip).show()


      editProdBody = (productObj, imgArr, vidImg) ->
        nesArr = []
        nesInp = $("#body-nesovershenstva").find("input[type='checkbox']:checked")
        if nesInp.length
          nesInp.each (i, data) ->
            nesArr.push($(data).val())
        else
          nesArr.push("body-nes-net") 
        type =
          type            : $("#product-tip").val()
          podType         : $(".activePodType > td > select").val()
          nesovershenstva : nesArr
        data =
          product : productObj
          type    : type


        newForm = new FormData()
        newForm.append("data",JSON.stringify data)
        imgArr.forEach (one, index) ->
          newForm.append(index, one)
        newForm.append("vid", vidImg)
        $.ajax
          type    : 'POST'
          data    : newForm
          url     : "/edit/body"
          cache: false
          contentType: false
          processData: false
          success : (data) ->
            window.location.reload()

      editProdFace = (productObj, imgArr, vidImg) ->
        
        kozhaArr = []
        kozhaInp = $("#face-koza").find("input[type='checkbox']:checked")
        if kozhaInp.length
          kozhaInp.each (i, data) ->
            kozhaArr.push($(data).val())
        else
          kozhaArr.push("face-kozh-all") 

        nesArr = []
        nesInp = $("#face-nesovershenstva").find("input[type='checkbox']:checked")
        if nesInp.length
          nesInp.each (i, data) ->
            nesArr.push($(data).val())
        else
          nesArr.push("face-nes-net")

        type =
          type            : $("#product-tip").val()
          podType         : $(".activePodType > td > select").val()
          kozha           : kozhaArr
          nesovershenstva : nesArr
        data =
          product : productObj
          type    : type


        console.log "data", data

        newForm = new FormData()
        newForm.append("data",JSON.stringify data)
        imgArr.forEach (one, index) ->
          newForm.append(index, one)
        newForm.append("vid", vidImg)
        $.ajax
          type    : 'POST'
          data    : newForm
          url     : "/edit/face"
          cache: false
          contentType: false
          processData: false
          success : (data) ->
            window.location.reload()
            
      clearProduct = () ->
        $("#prod-vid").val('')
        $("#brend-title").val('')
        $("#brend-min-disc").val('')
        $("#brend-obem").val('')
        $("#brend-ves").val('')
        $("#brend-id").val('')
        $("#brend-old-cost").val('')
        $("#brend-cost").val('')
        $("#brend-desc").val('')
        $("#brend-prim").val('')
        $("#ostatok").val('')
        $("#pic-tone").val("")
        $("#tone-prev").attr "src", "/img/add-bg.png"
        $("#del-img-tone").hide()
        i = 0
        arrDelStep = $(".del-step")
        while i < arrDelStep.length
          $item = arrDelStep[i]
          display = $($item).css("display")
          $($item).click() if display isnt "none"
          i++

      addEventE = () ->
        $(".del-step-e").unbind("click")
        $(".del-step-e").click () ->
          name = $(@).attr("id")
          name = name.replace("del-e-", "")
          withoutImg.push(name)
          $($(@).parent()).remove()
      
      $("#vid-tone-fs-del").click (e) ->
        $("#tone-prev").attr "src", "/img/add-bg.png"
        $(@).hide()
          
      renderImg = () ->
        console.log "prod.imgVid", prod.imgVid
        if prod.imgVid
          img = "/img/products/" + prod["_id"] + "/vid." + prod["imgVid"]
          $("#tone-prev").attr("src",img)
          $("#vid-tone-fs-del").show()
       
        prod.picture.forEach (item, index) ->
          template = _.template(jQuery('#stepEditTemplate').html())
          data = 
            id     : prod["_id"]
            name   : item
            number : index 
          $("#im-cont-step").append(template({data:data}))
        template2 = _.template(jQuery('#stepTemplate').html())
        $("#im-cont-step").append(template2({number:0}))
        addEvent()
        addEventE()

      prod = JSON.parse($("#firstData").val())
      typeProd = JSON.parse($("#firstData").attr("typeProd"))
      brendArr.forEach (brend) ->
        $option = $("<option/>")
        $option = $($option).val(brend["_id"])
        $option = $($option).text(brend.title)
        if brend["_id"] == prod.brend
          $($option).attr("selected", true)
        $("#brend-select").prepend($option)

#      $("option[value='" + typeProd.type + "']").attr("selected", true)
      $("#gl-product-tip").val(typeProd.type)
      renderType()
      selectFirstDate()
      renderImg()
  
      


#      for picture

  readURLStep = (input,idImg) =>
    template = _.template(jQuery('#stepTemplate').html())
    if input.files and input.files[0]
      if input.files[0].type.indexOf("image") != -1
        reader = new FileReader()
        reader.readAsDataURL input.files[0]
        reader.onload = (e) =>
          $(idImg).attr "src", e.target.result
          number = (Number idImg.replace("#step-img-",""))
          idDel = "#" + "del-step-" + number
          $(idDel).show()
          #для довления нового инпута
          all = ($("#im-cont-step").find(".step-inp")).length
          cheked = (Number idImg.replace("#step-img-",""))+1
          if cheked is all || all < cheked
            $("#im-cont-step").append(template({number:cheked}))
            addEvent()
      else
        alert("Такой фармат картинки не поддерживается")


  addEvent = (e) =>
    $(".step-inp").unbind("change")
    $(".del-step").unbind("click")
    $(".step-inp").change (e) ->
      id = $(@).attr("id")
      idImg = "#" + id.replace("inp","img")
      readURLStep this,idImg

    $(".del-step").click () ->
      $($(@).parent()).remove()
  addEvent()

  #for tone
  $("#pic-tone").change (e) ->
    if @.files and @.files[0]
      if @.files[0].type.indexOf("image") != -1
        reader = new FileReader()
        reader.readAsDataURL @.files[0]
        reader.onload = (e) =>
          $("#tone-prev").attr "src", e.target.result
          $("#del-img-tone").show()

  $("#del-img-tone").click () ->
    $("#pic-tone").val("")
    $("#tone-prev").attr "src", "/img/add-bg.png"
    $("#del-img-tone").hide()



$(document).ready () ->
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

      $("#gl-product-tip").click () ->
        renderType()

      $("#brend-show").click (e) ->
        $(".form-admin").hide()
        $("#brend-form").show()

      $("#product-list").click (e) ->
        $(".form-admin").hide()
        $("#product-list-form").show()

      $("#product-show").click (e) ->
        $(".form-admin").hide()
        $("#product-form").show()
        $("#brend-select").empty()
        brendArr.forEach (brend) ->
          $option = $("<option/>")
          $option = $($option).val(brend["_id"])
          $option = $($option).text(brend.title)
          $("#brend-select").prepend($option)
          
        renderType()


      $("#add-product-btn").click () ->
        vidString = $("#prod-vid").val()
        vidArr = vidString.split(",")
        vidArr = [] if vidArr.length is 1 and vidArr[0] is ""
        productObj =
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
              createProdFace(productObj, imgArr, vidImg)
        switch checkType
          when "body"
              createProdBody(productObj, imgArr, vidImg)


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


      createProdBody = (productObj, imgArr, vidImg) ->
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
          url     : "/create/body"
          cache: false
          contentType: false
          processData: false
          success : (data) ->
            alert("Добавлен!")
            clearProduct()

      createProdFace = (productObj, imgArr, vidImg) ->
        
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

        newForm = new FormData()
        newForm.append("data",JSON.stringify data)
        imgArr.forEach (one, index) ->
          newForm.append(index, one)
        newForm.append("vid", vidImg)
        $.ajax
          type    : 'POST'
          data    : newForm
          url     : "/create/face"
          cache: false
          contentType: false
          processData: false
          success : (data) ->
            alert("Добавлен!")
            clearProduct()

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




  renderProdTemplate = () ->
    templateJQ = $("#prodTypeTemplate")
    template = _.template($(templateJQ[0]).html())
    $("#gl-product-tip").append(template({data:window.nav}))
    templateJQ = $("#prodPodTypeTemplate")
    template = _.template($(templateJQ[0]).html())
    $("#admin-cont").append(template({data:window.nav}))


  renderProdTemplate()


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


# Для списка продуктов




  $("#start-search-prod ").click () ->
    title = $("#in-prod-search").val()
    findProd(title)

  $("#in-prod-search").autocomplete
    source: (request, response) ->
      $.ajax
        url: "/tool/admin/q_prod_by_name"
        data: {title: $("#in-prod-search").val()}
        success: (data) ->
          response $.map(data, (item) ->
            label : item.title
            title : item.title
          )
    minLength: 2


  renderProd = (products) ->
    $("#list-pr-body").empty()
    products.forEach (product) ->
        templateJQ = $("#prodListTemplate")
        template = _.template($(templateJQ[0]).html())
        data = (new moment(product.dateAdding)).format("DD/MM/YYYY")
        $("#list-pr-body").prepend(template({prod:product,data:data}))
    addEventList()

  findProd = (title) ->
    $.ajax
      type    : 'GET'
      data    : {title:title}
      url     : "/tool/admin/q_prod_by_name"
      success : (brends) ->
        renderProd(brends)
  
  addEventList = () ->
    $(".fn-act").unbind("click")
    $(".fn-del").unbind("click")
    $(".fn-act").click (e) ->
      if confirm("Вы уверенны?")
        id = ($(@).attr("id")).replace("vet-", "")
        act = $(@).attr("active")
        data = {
          id     : id
          active : act
        }
        $.ajax
          type: "POST"
          url: "/tool/admin/fn_vet_prod"
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
            url: "/tool/admin/del_product"
            data: {id:id}
            success: (data) =>
              $($($(@).parent()).parent()).remove()



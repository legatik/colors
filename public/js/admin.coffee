$(document).ready () ->
  $.ajax
    type    : 'GET'
    url     : "/tool/admin/q_brend"
    success : (brendArr) ->

      renderType = () ->
         checkType = $("#brend-tip").val()
         $(".add-param").remove()
         switch checkType
          when "face"
            templateJQ = $("#faceTemplate")
            template = _.template($(templateJQ[0]).html())
            $("#add-dish-table").append(template())


      $("#brend-show").click (e) ->
        $(".form-admin").hide()
        $("#brend-form").show()

      $("#add-brend").click (e) ->
        brendName = $("#brend-name").val()
        return if !brendName
        objSend = {brendName:brendName}
        $.ajax
          type    : 'GET'
          data    : objSend
          url     : "/tool/admin/create_brend"
          success : (brend) ->
            brendArr.push(brend)
            $("#brend-name").val("")
            $("#success-brend").hide()
            $("#success-brend").fadeIn("slow")
            console.log "brendArr",brendArr



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

      $("#add-brend-btn").click () ->
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
          brend            : $("#brend-select").val()
          picture          : []      
        imgArr = []
        $(".step-inp").each (index, one) ->
          if one.files.length != 0
            imgArr.push one.files[0]
        
        checkType = $("#brend-tip").val()
          
        switch checkType
          when "face"
              createProdFace(productObj, imgArr)
      
      
      createProdFace = (productObj, imgArr) ->
        type = 
          ottenok         : $("#brend-tone").val()
          type            : $("#tip-tip").val()
          kozha           : $("#brend-koza").val()
          nesovershenstva : $("#brend-nesovershenstva").val()
        data = 
          product : productObj
          type    : type
        
        newForm = new FormData()
        newForm.append("data",JSON.stringify data)
        imgArr.forEach (one, index) ->
          newForm.append("step"+index, one)
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
            $("#brend-tone").val('')
            $("#tip-tip").val('')
            $("#brend-koza").val('')
            $("#brend-nesovershenstva").val('')
      
      clearProduct = () ->
        $("#brend-title").val('')
        $("#brend-min-disc").val('')
        $("#brend-obem").val('')
        $("#brend-ves").val('')
        $("#brend-id").val('')
        $("#brend-old-cost").val('')
        $("#brend-cost").val('')
        $("#brend-desc").val('')
        $("#brend-prim").val('')
        i = 0
        arrDelStep = $(".del-step")
        while i < arrDelStep.length
          $item = arrDelStep[i]
          display = $($item).css("display")
          $($item).click() if display isnt "none"
          i++
        
        
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

        

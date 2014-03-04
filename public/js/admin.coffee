$(document).ready () ->
  $.ajax
    type    : 'GET'
    url     : "/tool/admin/q_brend"
    success : (brendArr) ->

      renderType = () ->
         checkType = $("#brend-tip").val()
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
#          picture          : Array
#          isFace           : {type: ObjectId, ref: 'Face'}
        
         checkType = $("#brend-tip").val()
         switch checkType
          when "face"
            createProdFace(productObj)
      
      
      createProdFace = (productObj) ->
        type = 
          ottenok         : $("#brend-tone").val()
          type            : $("#tip-tip").val()
          kozha           : $("#brend-koza").val()
          nesovershenstva : $("#brend-nesovershenstva").val()
        data = 
          product : productObj
          type    : type
        
        $.ajax
          type    : 'POST'
          data    : data
          url     : "/create/face"
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

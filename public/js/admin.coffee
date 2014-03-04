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
      console.log "sadsa", $("#add-brend")

      $("#add-brend-btn").click () ->
        console.log "add-brend"
        productObj = {
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
##  picture          : Array
##  isFace           : {type: ObjectId, ref: 'Face'}
        }

        createType (typeobj) ->
          alert()

      createType = (cb) ->
         checkType = $("#brend-tip").val()
         switch checkType
          when "face"
            key = "isFace"
            createTypeFace (typeobj, key) ->
              cb()
            
            
##  ottenok         : String
##  type            : String
##  kozha           : String
##  nesovershenstva : String
      createTypeFace = (cb) ->
        cb()
      
      

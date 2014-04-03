$(document).ready () ->
  skip = 0
  @inProgress = true
  min_price=49
  max_price=2599
  min = 49
  max = 2599
  brendArr = false
  searchParams = {
    special : {}
    product : {}
  }
  $("#slider-price").slider
    range: true
    min: min
    max: max
    values: [
      min
      max
    ]
    slide: (event, ui) ->
      $('.min-price').val ui.values[0]
      $('.max-price').val ui.values[1]
      min_price = ui.values[0]
      max_price = ui.values[1]
    change: (event, ui) ->
      skip = 0
      getProducts()


  $('.min-price').on 'change',  () ->
    val = $(this).val()
    if val>=min && val<max_price
      min_price = val
      $("#slider-price").slider values: [
        min_price
        max_price
      ]
    else
      $('.min-price').val min_price

  $('.max-price').on 'change',  () ->
    val = $(this).val()
    if val<=max && val>min_price
      max_price = val
      $("#slider-price").slider values: [
        min_price
        max_price
      ]
    else
      $('.max-price').val max_price

#  ************************************************************  #
  
  globalId = false
  
  renderResults = (products, scrollWindow) ->
    $(".res-search").empty() if !scrollWindow
    products.forEach (product) ->
      template = _.template(jQuery('#productTemplate').html())
      el = $(template({data:product}))
      $(".res-search").append(el)
      $(el).hide().fadeIn("slow")
  
  activAction = (id) ->
    action = {}
    globalId = id
    actions.forEach (item) ->
      action = item if item["_id"] == id
    src = "/img/actions/" + action["_id"] + "/" + "logo." + action["logo"]
    $("#promotions-picture").attr("src",src)
    skip = 0
    getProducts()

  getFilterParms = () ->
    objSent = {}
    objSent.min_price = $(".min-price").val()
    objSent.max_price = $(".max-price").val()
    objSent.sort = $(".sort-product").val()
    objSent.title = $(".search-product").val()
    return objSent
    
    
  getProducts = (scrollWindow) =>
    filter = getFilterParms()
    console.log "{key:renderKey, filter:filter}",{key:globalId, filter:filter}
    $.ajax
      type    : 'POST'
      url     : '/search/productByAction'
      data    : {key:globalId, filter:filter, skip:skip}
      beforeSend: =>
        @inProgress = true
      success : (products) =>
        @inProgress = false
        skip = skip + 24
        console.log "skip", skip
        renderResults(products, scrollWindow)

  
  actions = JSON.parse($("#firstData").attr("actions"))
  actionId = $("#firstData").attr("actionId")
  if actionId
    activAction(actionId)
  else
    elPromFirst = $(".prom-item").first()
    idFirst = $(elPromFirst).attr("idProm")
    activAction(idFirst)
    
  $(".prom-item").click (e) ->
    id = $(@).attr("idProm")
    activAction(id)

    

  $(".sort-product").click () ->
    skip = 0
    getProducts()

  keyTime = 0
  $(".search-product").unbind("keyup")
  $(".search-product").on "keyup", () ->
    clearTimeout(keyTime)
    keyTime = setTimeout(->
      skip = 0
      getProducts()
      return
    , 1000)
    
    
  $(window).scroll =>
    if $(window).scrollTop() + $(window).height() >= $(document).height() - 250 and not @inProgress
      getProducts(true)
      

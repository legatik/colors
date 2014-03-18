$(document).ready () ->
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


  brends = $("#firstData").attr("brends")
  brends = JSON.parse(brends)


  renderKey = $($(".brands > li").first()).attr("key")

  getFilterParms = () ->
    objSent = {}
    objSent.min_price = $(".min-price").val()
    objSent.max_price = $(".max-price").val()
    objSent.sort = $(".sort-product").val()
    objSent.title = $(".search-product").val()
    return objSent


  getProducts = () ->
    filter = getFilterParms()
    console.log "{key:renderKey, filter:filter}",{key:renderKey, filter:filter}
    $.ajax
      type    : 'POST'
      url     : '/search/productByBrend'
      data    : {key:renderKey, filter:filter}
      success : (products) ->
        renderResults(products)
    

  renderBrendInfo = () ->
    brend = false
    brends.forEach (item) ->
      brend = item if item["_id"].toString() == renderKey.toString()
    src = '/img/brends/' + brend['_id'] + "/" + "logo." + brend.logo
    $("#brands-picture").attr("src", src)
    $(".brand-info > p").text('')
    $(".brand-info > p").text(brend.description)
    liarr = $(".select-params > li")
    liarr.each (i, el)->
      $(el).attr("ischecked", "false")
    $(".select-params > li[key="+renderKey+"]").attr("ischecked","true")
    getProducts()

  $(".select-params > li").click () ->
    renderKey = $(@).attr("key")
    renderBrendInfo()

  renderBrendInfo(renderKey)

        
  renderResults = (products) ->
    $(".res-search").empty()
    products.forEach (product) ->
      template = _.template(jQuery('#productTemplate').html())
      el = $(template({data:product}))
      $(".res-search").append(el)
      $(el).hide().fadeIn("slow")



  $(".sort-product").click () ->
    getProducts()
    
        

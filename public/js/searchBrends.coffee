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
#    change: (event, ui) ->
#      collectParams()

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


  firstRender = $($(".brands > li").first()).attr("key")

  renderBrendInfo = (key) ->
    brend = false
    brends.forEach (item) ->
      brend = item if item["_id"].toString() == key.toString()
    src = '/img/brends/' + brend['_id'] + "/" + "logo." + brend.logo
    $("#brands-picture").attr("src", src)
    $(".brand-info > p").text('')
    $(".brand-info > p").text(brend.description)
    




  renderBrendInfo(firstRender)

#  collectParams = () ->
#    paramsArr = $(".special-params")
#    paramsArr.each (i, el) ->
#      key = $(el).attr("value")
#      searchParams.special[key] = [] 
#      liArr = $(el).find("li[ischecked='true']")
#      liArr.each (j, el2) ->
#        searchParams.special[key].push($(el2).attr("value"))
#    collectOtherParams()
      
        
#  renderResults = (products) ->
#    products.forEach (product) ->
#      $(".res-search").empty()
#      template = _.template(jQuery('#productTemplate').html())
#      el = $(template({data:product}))
#      $(".res-search").append(el)
#      $(el).hide().fadeIn("slow")
    
        
      
#  sendRequest = () ->
#    console.log "searchParams",searchParams
#    type = $("#nav-type").val()
#    url = "/search/filter/" + type
#    $.ajax
#      type    : 'POST'
#      url     : url
#      data    : searchParams
#      success : (products) ->
#        renderResults(products)
      
      

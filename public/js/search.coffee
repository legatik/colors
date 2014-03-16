$(document).ready () ->
  min_price=49
  max_price=2599
  min = 49
  max = 2599
  brendArr = false
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

  getBrend = (cb) ->
    if brendArr
      cb(brendArr)
    else
      $.ajax
        type    : 'GET'
        url     : "/search/q_brend"
        success : (brends) ->
          brendArr = brends
          cb(brends)
          
          
  renderFilter = (key) ->
    getBrend (brends) ->
      $(".left-side").empty()
      template = _.template(jQuery('#filerTemplate').html())
      $(".left-side").append(template(gdata: window.nav, data:window.nav[key], bdata:brends))
      $("#nav-type > option[value="+key+"]").attr("selected", true)
      addEvent()
  
  
  firstKey = $("#firstData").attr("search")
  if firstKey
    renderFilter(firstKey)
  else
    renderFilter("face")
    
  addEvent = () ->
    $("#nav-type").unbind("click")
    $("#nav-type").click (e) ->
      key = $(@).val()
      renderFilter(key)

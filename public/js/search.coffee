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
    
    
  $(".sort-product").click () ->
    collectParams()
    
  addEvent = () ->
    $("#nav-type").unbind("click")
    $(".select-params > li").unbind("click")
    $(".filter-type").unbind("click")
    $(".filter-pod-type").unbind("click")
    $(".select-price-cont").unbind("click")
    
    $("#nav-type").click (e) ->
      key = $(@).val()
      renderFilter(key)
 
    $(".select-params > li").click () ->
      checked = 0
      $ul = $(@).parent()
      liArr = $($ul).find("li")
      liArr.each (i, el) ->
        checked++ if $(el).attr("ischecked") == "true"
      if checked == liArr.length
        liArr.each (i, el) ->
          $(el).attr("ischecked", "false")
        $(@).attr("ischecked", "true")
      else 
        if $(@).attr("ischecked") == "true"
          $(@).attr("ischecked", "false")
          if checked == 1
            liArr.each (i, el) ->
              $(el).attr("ischecked", "true")
        else
          $(@).attr("ischecked", "true")
      collectParams()
      
    $(".filter-type").click (e) ->
      type = $(@).attr("value")
      searchParams.special = {}
      searchParams.special.type = type
      collectParams()
      
    $(".filter-pod-type").click (e) ->
      searchParams.special = {}
      type = $(@).attr("value")
      searchParams.special.podType = type
      collectParams() 
           
    $(".select-price-cont").click (e) ->
      collectParams()
     
  collectOtherParams = () ->
    searchParams.product.min_price = $(".min-price").val()
    searchParams.product.max_price = $(".max-price").val()
    searchParams.product.sort = $(".sort-product").val()
    
    paramsArr = $("#brend-filter")
    paramsArr.each (i, el) ->
      key = $(el).attr("value")
      searchParams.product[key] = [] 
      liArr = $(el).find("li[ischecked='true']")
      liArr.each (j, el2) ->
        searchParams.product[key].push($(el2).attr("value"))
    sendRequest()
    
  collectParams = () ->
    paramsArr = $(".special-params")
    paramsArr.each (i, el) ->
      key = $(el).attr("value")
      searchParams.special[key] = [] 
      liArr = $(el).find("li[ischecked='true']")
      liArr.each (j, el2) ->
        searchParams.special[key].push($(el2).attr("value"))
    collectOtherParams()
      
        
      
  sendRequest = () ->
    console.log "searchParams",searchParams
    type = $("#nav-type").val()
    url = "/search/filter/" + type
    $.ajax
      type    : 'POST'
      url     : "/search/filter"
      data    : searchParams
      success : (products) ->
          console.log "products", products
      
      

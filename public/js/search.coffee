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
    change: (event, ui) =>
      skip = 0
      collectParams()



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
      collectOtherParams()


  $(".sort-product").click () =>
    skip = 0
    collectParams()

  keyTime = 0
  $(".search-product").unbind("keyup")
  $(".search-product").on "keyup", () =>
    clearTimeout(keyTime)
    keyTime = setTimeout(=>
      skip = 0
      collectParams()
      return
    , 1000)

  addEvent = () ->
    $("#nav-type").unbind("click")
    $(".select-params > li").unbind("click")
    $(".filter-type").unbind("click")
    $(".filter-pod-type").unbind("click")

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
      skip = 0
      collectParams()

    $(".filter-type").click (e) ->
      $(".active-type").removeClass("active-type")
      $(@).addClass("active-type")
      type = $(@).attr("value")
      searchParams.special = {}
      searchParams.special.type = type if type
      skip = 0
      collectParams()

    $(".filter-pod-type").click (e) ->
      $(".active-type").removeClass("active-type")
      $(@).addClass("active-type")
      searchParams.special = {}
      type = $(@).attr("value")
      searchParams.special.podType = type
      skip = 0
      collectParams()


  collectOtherParams = (scrollWindow) ->
    searchParams.product.min_price = $(".min-price").val()
    searchParams.product.max_price = $(".max-price").val()
    searchParams.product.sort = $(".sort-product").val()
    searchParams.product.title = $(".search-product").val()

    paramsArr = $("#brend-filter")
    paramsArr.each (i, el) ->
      key = $(el).attr("value")
      searchParams.product[key] = []
      liArr = $(el).find("li[ischecked='true']")
      liArr.each (j, el2) ->
        searchParams.product[key].push($(el2).attr("value"))
    sendRequest(scrollWindow)

  collectParams = (scrollWindow) ->
    paramsArr = $(".special-params")
    paramsArr.each (i, el) ->
      key = $(el).attr("value")
      searchParams.special[key] = []
      liArr = $(el).find("li[ischecked='true']")
      liArr.each (j, el2) ->
        searchParams.special[key].push($(el2).attr("value"))
    collectOtherParams(scrollWindow)


  renderResults = (products, scrollWindow) ->
    $(".res-search").empty() if !scrollWindow
    products.forEach (product) ->
      template = _.template(jQuery('#productTemplate').html())
      el = $(template({data:product}))
      $(".res-search").append(el)
      $(el).hide().fadeIn("slow")



  sendRequest = (scrollWindow) =>
    searchParams.skip = skip
    type = $("#nav-type").val()
    searchParams.type = type
    url = "/search/filter"
    $.ajax
      type    : 'POST'
      url     : url
      data    : searchParams
      beforeSend: =>
        @inProgress = true
      success : (products) =>
        @inProgress = false
        skip = skip + 24
        renderResults(products, scrollWindow)


  firstKey = $("#firstData").attr("search")
  firstSort = $("#firstData").attr("sort")
  firstType = $("#firstData").attr("oType")
  firstPType = $("#firstData").attr("pType")
  
  searchParams.special.type = firstType if firstType
  searchParams.special.podType = firstPType if firstPType
  
  
  if firstSort == "new" 
    elFSort =$(".sort-product").find("option[value='popular']")
    $(elFSort).attr('selected', true)

  console.log "firstKey", firstKey
  if firstKey
    renderFilter(firstKey)
  else
    renderFilter("face")


  $(window).scroll =>
    if $(window).scrollTop() + $(window).height() >= $(document).height() - 250 and not @inProgress
      collectParams(true)



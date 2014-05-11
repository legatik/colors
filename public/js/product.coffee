$(document).ready () ->
  $(".addFav").click ()->
    idProd = $(@).attr("id")
    url = "/product/addFavoritesUser/" + idProd 
    $.ajax
      type    : 'POST'
      url     : url
      success : (data) =>
        $(".favorites").text("В избранном") if !data.err
        $(".favorites").removeClass("addFav")
        

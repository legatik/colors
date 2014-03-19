$(document).ready () ->
  $(".item-vetrina").first().addClass("active")
  $(".item-brend").first().addClass("active")
  console.log "HOME JS", $(".item-vetrina")
  $('.carousel').carousel()

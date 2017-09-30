checkZero = (input) ->
  if input.value == 0
    input.setCustomValidity('El número debe ser mayor a cero');
  else
    input.setCustomValidity('');

$(document).ready () ->
  $('.donation-extraction-submit').submit () ->
    $(":hidden").remove()
    return true

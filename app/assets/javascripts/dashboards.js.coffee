$ ->
  $('#music').show()

  $('.new-request').on 'click', ->
    $('.request-well').hide()
    $('#' + $(@).attr('id') + '-request').show()

  $('.btn').on 'click', ->
    $('.requests').hide()
    name = $(@).text().toLowerCase()
    name = name.replace(' ', '-')
    $("##{name}").show()

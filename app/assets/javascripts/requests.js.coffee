class Requests
  constructor: () ->
    $.getJSON '/requests.json', (data) =>
      @type = 'music'
      @data = {}
      @data['music'] = data[0]
      @data['movies'] = data[1]
      @data['tv-shows'] = data[2]
      @data['software'] = data[3]
      @data['games'] = data[4]
      @data['other'] = data[5]

  setType: (type) ->
    @type = type
    @.render()

  upvote: (index, id) ->
    @data[@type][index]['vote']++

    $.post '/requests/' + id + '/upvote', (data) ->
      console.log data
    , 'json'

    if index != 0 &&  @data[@type][index]['vote'] >= @data[@type][index - 1]['vote']

      tmp = @data[@type][index]
      @data[@type][index] = @data[@type][index - 1]
      @data[@type][index - 1] = tmp

    @.render()

  downvote: (index, id) ->
    @data[@type][index]['vote']--

    $.post '/requests/' + id + '/downvote', (data) ->
      console.log data
    , 'json'

    if index != @data[@type].length - 1 && @data[@type][index]['vote'] < @data[@type][index + 1]['vote']

      tmp = @data[@type][index]
      @data[@type][index] = @data[@type][index + 1]
      @data[@type][index + 1] = tmp

    @.render()

  render: ->
    content = @data[@type]

    html = ''

    for i in [0..content.length - 1]
      html += '<div><span data-index="' + i + '" data-id="' + content[i]['id'] + '">' + content[i]['title'] + '&nbsp;</span>'
      html += '<a href="#" class="upvote"><span>&#x25B2;</span></a>'
      html += '<span class="vote">(' + content[i]['vote'] + ')</span>'
      html += '<a href="#" class="downvote"><span>&#x25BC;</span></a>'
      if i != content.length - 1
        html += '<hr>'
      html += '</div>'

    $("##{@type} .request-content").html html

$ ->
  window.requests = new Requests

  $('#music').show()

  $('#movies-title').typeahead
    source: (query, process) ->
      $.getJSON 'http://api.themoviedb.org/3/search/movie?api_key=' +
        window.tmdb_key + '&query=' + escape(query), (data) ->
          console.log data
          process data.results
    items: 5
    minLength: 2
    sorter: (items) ->
      items
    matcher: (item) ->
      true
    highlighter: (item) ->
      html = '<div>'
      html += '<img style="float:left;margin-right:5px" src="http://cf2.imgobject.com/t/p/w92' + item.poster_path + '">'
      html += '<span style="overflow:auto">' + item.title + '</span><br>'
      html += '<span>Rating: ' + item.vote_average + '/10</span></div>'
      html += '<div style="clear:both"></div>'
      html

  $('#music-artist').typeahead
    source: (query, process) ->
      $.get 'http://www.musicbrainz.org/ws/2/artist/?query=artist:' +
        escape(query), (data) ->
          items = []

          $(data).find('artist').each ->
            item = {}
            name = $(@).find('name')
            item.title = $(name[0]).text()

            begin = $(@).find('life-span').find('begin').text()
            ended = $(@).find('life-span').find('ended').text()
            if ended == 'false'
              ended = 'Present'
            else if ended == 'true'
              ended = 'Unknown'

            if begin == ''
              item.time = 'Currently Active'
            else
              item.time = begin + ' - ' + ended
            items.push item
          process items
      , 'xml'
    items: 5
    minLength: 2
    sorter: (items) ->
      items
    matcher: (item) ->
      true
    highlighter: (item) ->
      html = '<div>'
      html += '<span>' + item.title + '</span><br>'
      html += '<span>' + item.time + '</span></div>'
      html

  $('#music-album').typeahead
    source: (query, process) ->
      $.get 'http://www.musicbrainz.org/ws/2/release-group/?query=release:' +
        escape(query), (data) ->
          console.log data
          items = []

          $(data).find('release-group').each ->
            item = {}
            item.title = $($(@).find('title')[0]).text()

            item.artist = $($(@).find('name')[0]).text()

            items.push item
          process items
      , 'xml'
    items: 5
    minLength: 2
    sorter: (items) ->
      items
    matcher: (item) ->
      true
    highlighter: (item) ->
      html = '<div>'
      html += '<span>' + item.title + '</span><br>'
      html += '<span>by ' + item.artist + '</span></div>'
      html

  # $('#movies-title').on 'input', ->
  #   query = $(@).val()

  #   if query.length > 1
  #     $.getJSON 'http://api.themoviedb.org/3/search/movie?api_key=' +
  #     window.api_key + '&query=' + escape(query), (data) ->
  #       console.log data

  $('.new-request').on 'click', ->
    $('.request-well').hide()
    $('.new-request').removeClass 'active'
    $(@).addClass 'active'
    $('#' + $(@).attr('id') + '-request').show()

  $('.btn').on 'click', ->
    $('.requests').hide()
    name = $(@).text().toLowerCase()
    name = name.replace(' ', '-')
    $("##{name}").show()
    requests.setType name
    requests.render()

  $(document).on 'click', '.upvote', ->
    el = $(@).siblings('span')
    requests.upvote $(el).data('index'), $(el).data('id')

  $(document).on 'click', '.downvote', ->
    el = $(@).siblings('span')
    requests.downvote $(el).data('index'), $(el).data('id')

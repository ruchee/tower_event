# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
#= require jquery/dist/jquery

page = 2
text = $('#btn-load-more')

$(->
  $(window).scroll(->
    if $(this).scrollTop() + $(window).height() + 20 >= $(document).height() && $(this).scrollTop() > 20
      $.ajax(
        url: '/events/more'
        dataType: 'html'
        type: 'get'
        data:
          page: page
        success: (data) ->
          if $.trim(data).length > 0
            $('#events').append(data)
            $('#events').append(text)
            page++
          else
            text.text('没有更多内容了')
      )
  )
)

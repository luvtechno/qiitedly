# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->
  $('#user').each ->
    userId = $(this).data('id')
    reload = $(this).data('reload')
    console.log userId
    console.log reload
    if reload
      $.ajax
        url: "/users/#{userId}"
        type: 'get'
        dataType: 'script'

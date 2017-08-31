# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
editQuestionFunction = (e) ->
  e.preventDefault();
  $(this).hide();
  $('form#edit-question').show();

$(document).on 'click', '.question .edit-question-link', editQuestionFunction
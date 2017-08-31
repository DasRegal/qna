# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
editAnswerFunction = (e) ->
  e.preventDefault();
  $(this).hide();
  answer_id = $(this).data('answerId');
  $('form#edit-answer-' + answer_id).show();

$(document).on 'click', '.answers .edit-answer-link', editAnswerFunction

deleteAnswerFunction = (e) ->
  e.preventDefault();
  answer_id = $(this).data('answerId');
  $('#answer_id_' + answer_id).hide();

$(document).on 'click', '.answers .delete-answer-link', deleteAnswerFunction
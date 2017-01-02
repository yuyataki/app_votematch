import $ from 'jquery';

function clickQuestionAgree() {
  $('.j__question_agree').click(function() {
    changeClass($(this), 'agree');
    addValue($(this), 'agree');
  });
  $('.j__question_neutral').click(function() {
    changeClass($(this), 'neutral');
    addValue($(this), 'neutral');
  });
  $('.j__question_opposition').click(function() {
    changeClass($(this), 'opposition');
    addValue($(this), 'opposition');
  });
}

function changeClass(element, value) {
  let classes = ['agree', 'neutral', 'opposition']
  let removeClasses = classes.filter(function(v) { return v !== value; });
  element.toggleClass(`question-${value}-click`, 500);
  element.siblings().removeClass(`question-${removeClasses[0]}-click`, 500);
  element.siblings().removeClass(`question-${removeClasses[1]}-click`, 500);
}

function addValue(element, value) {
  let question_id = element.parent().attr('id');

  $(`#question_${question_id}`).remove();
  $('<input>', {
    type: 'hidden', class: 'j__hidden_position',
    id: `question_${question_id}`, name: `choice[${question_id}]`, value: value
  }).appendTo(element);
}

function toggleDisabled() {
  $('.j__question_position').click(function() {
    if($('.j__hidden_position').length === $('.j__question_content').length) {
      $('.j__show_result').prop('disabled', false);
    }
  });
}

$(() => {
  clickQuestionAgree();
  toggleDisabled();
});

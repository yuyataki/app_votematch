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
    type: 'hidden', id: `question_${question_id}`, name: `choice[${question_id}]`, value: value
  }).appendTo(element);
}

$(() => {
  clickQuestionAgree();
});

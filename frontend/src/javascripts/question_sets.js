import $ from 'jquery';

function clickQuestionAgree() {
  for(let question_id of gon.question_ids) {
    $(`.j__question_agree_${question_id}`).click(function() {
      $(`.j__question_agree_${question_id}`).toggleClass('question-agree-click', 500);
      $(`.j__question_neutral_${question_id}`).removeClass('question-neutral-click', 500);
      $(`.j__question_opposition_${question_id}`).removeClass('question-opposition-click', 500);
    });
    $(`.j__question_neutral_${question_id}`).click(function() {
      $(`.j__question_agree_${question_id}`).removeClass('question-agree-click', 500);
      $(`.j__question_neutral_${question_id}`).toggleClass('question-neutral-click', 500);
      $(`.j__question_opposition_${question_id}`).removeClass('question-opposition-click', 500);
    });
    $(`.j__question_opposition_${question_id}`).click(function() {
      $(`.j__question_agree_${question_id}`).removeClass('question-agree-click', 500);
      $(`.j__question_neutral_${question_id}`).removeClass('question-neutral-click', 500);
      $(`.j__question_opposition_${question_id}`).toggleClass('question-opposition-click', 500);
    });
  }
}

$(() => {
  clickQuestionAgree();
});

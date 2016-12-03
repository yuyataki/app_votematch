import $ from 'jquery';

function addQuestionScore() {
  for(let party_id of gon.parties) {
    $(`#j__delete_${party_id}`).click(function() {
      $(`#j__party_${party_id}`).empty();
    });
    $(`.j__point_${party_id}`).change(function() {
      let points = [];
      $(`.j__point_${party_id}`).each(function(i, element) {
        if($(element).val() !== '') {
          points.push(Number($(element).val()));
        }
      });
      let pointTotal = points.reduce(function(previous, current) {
        return previous + current
      });
      if(points.length === 3 && pointTotal !== 10) {
        $(`#j__alert_${party_id}`).text('ポイントの合計は10にしてください。');
      } else {
        $(`#j__alert_${party_id}`).empty();
      }
    });
  }
}

function showQuestionScore() {
  $('.j__show_question_score').click(function() {
    $(this).next('.accordion').slideToggle(300);
    $('.j__accordion_change', this).toggleClass('fa-caret-square-o-down fa-caret-square-o-up');
  });
}

$(() => {
  addQuestionScore();
  showQuestionScore();
});

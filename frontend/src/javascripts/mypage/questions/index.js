import $ from 'jquery';

function addQuestionScore() {
  for(let party_id of gon.parties || []) {
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
      let alertArea = $(this).parent().parent().children('td:last-child').children('span');
      if(points.length === 3 && pointTotal !== 10) {
        alertArea.text('ポイントの合計は10にしてください。');
      } else {
        alertArea.empty();
      }
    });
  }
}

function removeParty() {
  $('.j__delete_party').click(function() {
    $(this).parent().parent().empty();
  });
}

function showQuestionScore() {
  $('.j__show_question_score').click(function() {
    $(this).next('.accordion').slideToggle(300);
    $('.j__accordion_change', this).toggleClass('fa-caret-square-o-down fa-caret-square-o-up');
  });
}

$(() => {
  removeParty();
  addQuestionScore();
  showQuestionScore();
});

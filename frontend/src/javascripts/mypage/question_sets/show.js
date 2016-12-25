import $ from 'jquery';
let partiesNotDeleted;

function checkQuestionScore() {
  if(gon.parties === undefined) { gon.parties = [] }

  for(let i = 0; i < gon.parties.length; i++) {
    $(`.j__point_${gon.parties[i]}`).change(function() {
      getTotalScore();
      let points = [];
      $(`.j__point_${gon.parties[i]}`).each(function(i, element) {
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
function getTotalScore() {
  let sum = 0;
  let parties = partiesNotDeleted === undefined ? gon.parties : partiesNotDeleted
  for(let i = 0; i < parties.length; i++) {
    $(`.j__point_${parties[i]}`).each(function(i, element) {
      sum = sum + Number($(element).val());
    });
  }
  if(sum === parties.length * 10) {
    $('.j__add_question').prop('disabled', false);
  } else {
    $('.j__add_question').prop('disabled', true);
  }
}
function removeParty() {
  $('.j__delete_party').click(function() {
    $(this).parent().parent().empty();
    partiesNotDeleted = $('.j__delete_party').map(function() {
      return $(this).parent().parent().attr('id').split('_')[3];
    });
  });
}

function showQuestionScore() {
  $('.j__show_question_score').click(function() {
    $(this).next('.accordion').slideToggle(300);
    $('.j__accordion_change', this).toggleClass('fa-caret-square-o-down fa-caret-square-o-up');
    let position = $(this).offset().top;
    $('html, body').animate({ scrollTop : position }, { queue : false });
  });
}

function toggleQuestionSetTitle() {
  $('.j__edit-submit-button').click(function() {
    $('.j__show-title').toggle();
    $('.j__edit-title').toggle();
  });
}

$(() => {
  removeParty();
  checkQuestionScore();
  showQuestionScore();
  toggleQuestionSetTitle();
});

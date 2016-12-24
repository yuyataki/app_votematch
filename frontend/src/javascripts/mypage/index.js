import './question_sets';
import $ from 'jquery';

function alertOpen() {
  $('.j__delete_question_set').click(function() {
    let con = confirm('本当に削除しますか?');
    if(con === true) {
      return true
    } else {
      return false
    }
  });
}

$(() => {
  alertOpen();
});

import $ from 'jquery';
function toggleTab() {
  $('.j__tab').click(function() {
    $(this).removeClass('not-selected').addClass('selected');
    $(this).siblings().removeClass('selected').addClass('not-selected');

    if($(this).hasClass('j__latest')) {
      $('.j__latest-sets').show();
      $('.j__latest-sets').siblings().hide();
    } else if($(this).hasClass('j__famous')) {
      $('.j__famous-sets').show();
      $('.j__famous-sets').siblings().hide();
    }
  });
}

$(() => {
  toggleTab();
});

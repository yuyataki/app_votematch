import $ from 'jquery';

function animateResultPoint() {
  let partiesPoints = gon.parties_points || []

  for(let i = 0; i < partiesPoints.length; i++) {
    $(`.j__party_${partiesPoints[i][0]}`).animate({
      width: `${(partiesPoints[i][2]) * 0.95}%`,
    }, 1000);
  }
}

$(() => {
  animateResultPoint();
});

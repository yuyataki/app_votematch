import $ from 'jquery';

function animateResultPoint() {
  let partiesPoints = gon.parties_points || []
  let maxPoint = Math.max.apply(
    null, partiesPoints.map(function(element, index, array) { return element[1] })
  );
  for(let i = 0; i < partiesPoints.length; i++) {
    $(`.j__party_${partiesPoints[i][0]}`).animate({
      width: `${(partiesPoints[i][1] * 100 / maxPoint) * 0.85}%`,
    }, 1000);
  }
}

$(() => {
  animateResultPoint();
});

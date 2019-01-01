$(document).ready(function() {
  $('#expand_review').on ('click', function(){
    if ( $(this).hasClass( 'expanded' ) ) {
      $(this).text("Leave A Review");
      $(this).toggleClass('expanded')
    } else {
      $(this).text('Collapse');
      $(this).toggleClass('expanded')
    }
  })
});

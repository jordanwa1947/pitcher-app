$(document).ready(function() {
  $('#expand_review').on ('click', function(){
    $(this).toggleClass('expanded')
    if ( $(this).hasClass( 'btn btn-primary expanded' ) ) {
      $(this).text( 'Collapse' );
    } else {
      $(this).text( "Leave A Review" );
    }
  })
});

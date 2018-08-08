$(document).ready(function () {
  $(window).scroll(function () {
    if ($(this).scrollTop() > 100) {
      $('#back-to-top').fadeIn();
    } else {
      $('#back-to-top').fadeOut();
    }
  });
  $('#back-to-top').click(function () {
    $('html, body').animate({scrollTop: 0}, 600);
    return false;
  });
  $('#select-category').change(function() {
    $('#search-rooms').submit();
  });

  $('#select-floor').change(function() {
    $('#search-rooms').submit();
  });
});

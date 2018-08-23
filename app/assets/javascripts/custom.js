$(document).on('turbolinks:load', function () {
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
  $('#search-rooms select').change(function() {
    $('#search-rooms').submit();
  });
  $('#print-button').on('click', function() {
    $('#print-bill').siblings().hide();
    window.print();
    $('#print-bill').siblings().show();
  });
});

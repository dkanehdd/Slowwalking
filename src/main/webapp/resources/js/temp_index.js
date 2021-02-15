hideChat(0);

$('#prime').click(function() {
  toggleFab();
});

function toggleFab() {
  $('.chat').toggleClass('is-visible');
  $('.fab').toggleClass('is-visible');
  $('#chat_converse').toggleClass('is-visible')
  $('#chat_converse').css('display', 'block');
  
}

  $('#prime').click(function(e) {
      
      $('.fab_field').toggleClass('fab_field2');
      $('.chat_converse').toggleClass('chat_converse2');
  });

function hideChat(hide) {
    switch (hide) {
      case 0:
            $('#chat_converse').css('display', 'none');
            break;
      case 1:
            $('#chat_converse').css('display', 'block');
            break;
      case 2:
            $('#chat_converse').css('display', 'none');
            break;
      case 3:
            $('#chat_converse').css('display', 'none');
            break;
      case 4:
            $('#chat_converse').css('display', 'none');            
            break;
    }
}
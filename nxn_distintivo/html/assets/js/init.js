$(document).ready(function(){
  window.addEventListener('message', function( event ) {
    if (event.data.action == 'open') {
      var type        = event.data.type;
      var matricola = event.data.matricola
      if ( type == 'driver' || type == null) {
        $('img').show();
        $('#matricola').text(matricola);
        $('#id-card').css('background', 'url(assets/images/idcard.png)');
      } 
      $('#id-card').show();
    } else if (event.data.action == 'close') {
      $('#id-card').hide();
    }
  });
});
// utisss.#0672
$(document).ready(function(){


    if ( $('div#notice').length ) {
  
      $('div#notice').addClass("box-notification");
      $('div#notice').addClass("box-notification-sombra");
      $('div#notice').addClass("animateOpen");
  
      $('button.close').addClass("hide");
  
      setTimeout(function(){
        $(".box-notification.box-notification-sombra").removeClass("animateOpen");
        $(".box-notification.box-notification-sombra").addClass("animateClose");
      }, 3000);
      setTimeout(function(){
        $( "div#notice" ).remove();
      }, 3000);

    }
  
  
})